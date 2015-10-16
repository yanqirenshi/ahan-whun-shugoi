#|
  This file is a part of ahan-whun-sgoi project.
  Copyright (c) 2015 Satoshi Iwasaki (yanqirenshi@gmail.com)
|#

#|
  Author: Satoshi Iwasaki (yanqirenshi@gmail.com)
|#

(in-package :cl-user)
(defpackage ahan-whun-sgoi-asd
  (:use :cl :asdf))
(in-package :ahan-whun-sgoi-asd)

(defsystem ahan-whun-sgoi
  :version "0.1"
  :author "Satoshi Iwasaki"
  :license "MIT"
  :depends-on (:cl-ppcre
               :trivial-shell
               :jonathan
               :upanishad
               :shinrabanshou)
  :components ((:module "src"
                :components
                ((:file "package")
                 (:file "aws" :depends-on ("package"))
                 (:file "ec2" :depends-on ("aws"))
                 (:file "elb" :depends-on ("aws"))
                 (:file "s3" :depends-on ("aws")))))
  :description ""
  :long-description
  #.(with-open-file (stream (merge-pathnames
                             #p"README.markdown"
                             (or *load-pathname* *compile-file-pathname*))
                            :if-does-not-exist nil
                            :direction :input)
      (when stream
        (let ((seq (make-array (file-length stream)
                               :element-type 'character
                               :fill-pointer t)))
          (setf (fill-pointer seq) (read-sequence seq stream))
          seq)))
  :in-order-to ((test-op (test-op ahan-whun-sgoi-test))))
