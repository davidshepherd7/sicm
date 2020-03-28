
;; (define ((parametric-path-action Lagrangian t0 q0 t1 q1)
;;          intermediate-qs)
;;   (let ((path (make-path t0 q0 t1 q1 intermediate-qs)))
;;     ;; display path
;;     ;; (sleep-current-thread 100)
;;     (graphics-clear win2)
;;     (plot-function win2 path t0 t1 (/ (- t1 t0) 100))
;;     ;; compute action
;;     (Lagrangian-action Lagrangian path t0 t1)))

;; (define (find-path Lagrangian t0 q0 t1 q1 n)
;;   (let ((initial-qs (linear-interpolants q0 q1 n)))
;;     (let ((minimizing-qs
;;            (multidimensional-minimize
;;             (parametric-path-action Lagrangian t0 q0 t1 q1)
;;             initial-qs)))
;;       (print-expression ((make-path t0 q0 t1 q1 minimizing-qs) 't)))))

(define ((L-free-particle mass) local)
  (let ((v (velocity local)))
    (* 1/2 mass (dot-product v v))))


;; (define (test-path t)
;;   (up (+ (* 4 (square t)) 7)
;;       (+ (* 3 t) 5)
;;       (+ (* 2 t) 1)))

(define ((make-eta nu t1 t2) t)
  (* (- t t1) (- t t2) (nu t)))


(define ((varied-free-particle-action mass q nu t1 t2) eps)
  (let ((eta (make-eta nu t1 t2)))
    (Lagrangian-action (L-free-particle mass)
                       (+ q (* eps eta))
                       t1
                       t2)))


(define t0 0.0)
(define t1 2.0)
(define win2 (frame t0 t1 -1.0 11.0))

(define path (make-path t0 0.0 t1 1.0 (linear-interpolants t0 t1 5)))

;; This can't be a path for a free particle because the velocity = D(2t^2) = 4t
;; is not constant.
(define (bad-path t) (+ (* 2 (expt t 2))))

(define (good-path t) (+ (* 2 t)))

;; (print-expression (bad-path 't))
;; (graphics-clear win2)
;; (plot-function win2 bad-path t0 t1 (/ (- t1 t0) 100))

;; (print-expression ((varied-free-particle-action 3.0
;;                                                 bad-path
;;                                                 sin
;;                                                 t0 t1) 0))

(minimize
 (varied-free-particle-action 3.0
                              bad-path
                              sin
                              t0 t1)
 -2.0 1.0)

(minimize
 (varied-free-particle-action 3.0
                              good-path
                              sin
                              t0 t1)
 -2.0 1.0)



;; This doesn't seem to have done anything to detect that the paths provided are
;; impossible, the impossible one just has a much bigger action. That's what I
;; would expect - most of the paths given are impossible, in fact even the
;; numerical "answers" are not the true path. The algorithm probably can't tell
;; the difference.
