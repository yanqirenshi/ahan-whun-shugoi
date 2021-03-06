#|
  This file is a part of ahan-whun-shugoi-beach project.
|#

(defsystem "ahan-whun-shugoi-beach"
  :version "0.1.0"
  :author ""
  :license ""
  :depends-on (:cl-ppcre
               :local-time
               :jonathan
               :upanishad
               :shinrabanshou
               :closure-html
               :closure-html-adapter
               :dexador
               :lparallel)
  :components ((:module "src"
                :components
                ((:file "graph")
                 (:module "utilities" :components ((:file "etc")
                                                   (:file "html")
                                                   (:file "locker")
                                                   (:file "uri")))
                 (:file "package")
                 (:module "class" :components ((:file "sand")
                                               (:file "aws")
                                               (:file "command")
                                               (:file "subcommand")
                                               (:file "option")
                                               (:file "relashonship")
                                               (:file "finder")))
                 (:file "finder")
                 (:file "outputs")
                 (:file "options")
                 (:module "parser" :components ((:file "synopsis")
                                                (:file "options")
                                                (:file "merge")))
                 (:file "subcommands")
                 (:file "commands")
                 (:file "aws"))))
  :description ""
  :long-description
  #.(read-file-string
     (subpathname *load-pathname* "README.markdown"))
  :in-order-to ((test-op (test-op "ahan-whun-shugoi-beach-test"))))
