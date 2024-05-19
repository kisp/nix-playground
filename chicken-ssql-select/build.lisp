(load (sb-ext:posix-getenv "ASDF"))

(asdf:load-system "alexandria")
(asdf:load-system "cl-ppcre")

(use-package :alexandria)

(defun build-inputs ()
  (ppcre:split "\\s+" (posix-getenv "buildInputs")))

(defun direct-propagated-build-inputs (build-input)
  (let ((manifest-file
	 (merge-pathnames "nix-support/propagated-build-inputs"
			  (parse-namestring (format nil "~A/" build-input)))))
    (when (probe-file manifest-file)
      (ppcre:split "\\s+"
		   (read-file-into-string manifest-file)))))

(defun propagated-build-inputs (build-input)
  (cons build-input
	(mappend #'propagated-build-inputs
		 (direct-propagated-build-inputs build-input))))

(defun lib-chicken-11 (build-input)
  (format nil "~A/lib/chicken/11" build-input))

(defun run-csc (&key input output repository-paths)
  (let ((process
	 (sb-ext:run-program
	  (sb-ext:posix-getenv "csc")
	  (list input
		"-prelude"
		(format nil "'( (import (chicken platform)) (repository-path (list ~{~S~^ ~}) ) )'"
			repository-paths)
		"-o" output)
	  :output "log"
	  :environment (cons (format nil "CHICKEN_REPOSITORY_PATH=~{~A~^:~}"
				     repository-paths)
			     (posix-environ)))))
    (write-line (read-file-into-string "log"))
    (finish-output)
    (assert (zerop (sb-ext:process-exit-code process)))))

(let ((repository-paths
       (mapcar #'lib-chicken-11
	       (mappend #'propagated-build-inputs (build-inputs)))))
  (uiop:run-program "mkdir -p $out/bin")
  (run-csc :input (sb-ext:posix-getenv "SOURCE")
	   :output (format nil "~A/~A"
			   (sb-ext:posix-getenv "out")
			   (sb-ext:posix-getenv "OUTPUT"))
	   :repository-paths repository-paths))
