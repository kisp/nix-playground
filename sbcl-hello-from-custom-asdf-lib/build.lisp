(load (sb-ext:posix-getenv "ASDF"))

(asdf:load-system "alexandria")
(asdf:load-system "custom-lib")

(defun main ()
  (format t "Hello!~%")
  (format t "Hello alexandria: ~A~%" (alexandria:iota 10))
  (format t "Hello custom-lib: ~A~%" (custom-lib:hello "World"))
  (format t "Hello custom-lib using iterate: ~A~%" (custom-lib:hello-iterate))
  (format t "Hello custom-lib using borda-count: ~A~%" (custom-lib:hello-borda-count '((a b c)))))

(sb-ext:save-lisp-and-die
 "app"
 :toplevel #'main
 :executable t)
