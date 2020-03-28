
(define ((L-free-particle mass) local)
  (let ((v (velocity local)))
    (* 1/2 mass (dot-product v v))))

(define q
  (up (literal-function 'x)))

;; (define (Lagrangian-action L q t1 t2)
;;   (definite-integral (compose L (Gamma q)) t1 t2))

(print-expression ((compose (L-free-particle 'm) (Gamma q)) 't))

(print-expression (Lagrangian-action (L-free-particle 'm) q 't1 't2))
