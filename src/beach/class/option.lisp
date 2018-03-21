(in-package :aws.beach)

(defclass option (sand)
 ((display :accessor display :initarg :display :initform nil)
  (stroke  :accessor stroke  :initarg :stroke  :initform '(:color (:r 217 :g 51 :b 63 :a 0.1) :width 5)))
  (:documentation "コマンドを現わすクラスです。

# Relashonship

```
 option --+--1:1--> 2json
          `--1:1--> 2class-instance
```
"))

(defmethod jojo:%to-json ((obj option))
  (jojo:with-object
    (jojo:write-key-value "_id"         (slot-value obj 'up:%id))
    (jojo:write-key-value "code"        (slot-value obj 'code))
    (jojo:write-key-value "name"        (slot-value obj 'code)) ;; web/ での表示用
    (jojo:write-key-value "description" "") ;; web/ での表示用
    (jojo:write-key-value "location"    (slot-value obj 'location))
    (jojo:write-key-value "display"     (let ((v (slot-value obj 'display))) (or v :false)))
    (jojo:write-key-value "stroke"      (slot-value obj 'stroke))
    (jojo:write-key-value "_class" "OPTION")))
