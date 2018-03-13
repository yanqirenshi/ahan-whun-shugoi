(in-package :cl-user)
(defpackage ahan-whun-shugoi-api-asd
  (:use :cl :asdf))
(in-package :ahan-whun-shugoi-api-asd)

(defsystem ahan-whun-shugoi-api
  :version "0.1"
  :author ""
  :license ""
  :depends-on (:clack
               :lack
               :caveman2
               :envy
               :cl-ppcre
               :uiop
               :lack-middleware-validation
               :jonathan
               ;; Database
               :upanishad
               :shinrabanshou
               :sephirothic)
  :components ((:module "src"
                :components
                ((:file "config")
                 (:module "controller"
                  :components ((:file "package")))
                 (:file "render")
                 (:module "router"
                  :components ((:file "route")
                               (:file "api-v1")))
                 (:file "main"))))
  :description ""
  :in-order-to ((test-op (load-op ahan-whun-shugoi-api-test))))