;; Run with ./run.sh -f test.scm

(display "1\n")

(define ((L-free-particle mass) local)
  (let ((v (velocity local)))
    (* 1/2 mass (dot-product v v))))

(define q
  (up (literal-function 'x)
      (literal-function 'y)
      (literal-function 'z)))

(print-expression (q 't))
