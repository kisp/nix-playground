(eval-when (:compile-toplevel)
  (use-package :iterate))

(defun format-number (x)
  (format t "~A~%" x))

(defun run ()
  (iter
    (for i from 1 to 10)
    (format-number i)))

(run)
