(in-package :aws.beach)

(defclass subcommand (sand)
  ((synopsis :accessor synopsis :initarg :synopsis :initform nil)
   (examples :accessor examples :initarg :examples :initform nil)
   (output   :accessor output   :initarg :output   :initform nil)
   (uri      :accessor uri      :initarg :uri      :initform nil)
   (lock     :accessor lock     :initarg :lock     :initform t)
   (display  :accessor display  :initarg :display  :initform nil)
   (stroke   :accessor stroke   :initarg :stroke   :initform '(:color (:r 217 :g 51 :b 63 :a 0.5) :width 5)))
  (:documentation "コマンドを現わすクラスです。

# Relashonship

```
 subcommand --1:n--> option
```
"))

(defmethod jojo:%to-json ((obj subcommand))
  (jojo:with-object
    (jojo:write-key-value "_id"         (slot-value obj 'up:%id))
    (jojo:write-key-value "code"        (slot-value obj 'code))
    (jojo:write-key-value "name"        (slot-value obj 'code)) ;; web/ での表示用
    (jojo:write-key-value "description" (slot-value obj 'description))
    (jojo:write-key-value "uri"         (slot-value obj 'uri))
    (jojo:write-key-value "lock"        (slot-value obj 'lock))
    (jojo:write-key-value "location"    (slot-value obj 'location))
    (jojo:write-key-value "display"     (let ((v (slot-value obj 'display))) (or v :false)))
    (jojo:write-key-value "stroke"      (slot-value obj 'stroke))
    (jojo:write-key-value "_class"      "SUBCOMMAND")))


(defun subcommand2response-display (obj)
  (list :_id     (slot-value obj 'up:%id)
        :code    (slot-value obj 'code)
        :uri     (slot-value obj 'uri)
        :display (let ((v (slot-value obj 'display))) (or v :false))
        :_class  "SUBCOMMAND"))
