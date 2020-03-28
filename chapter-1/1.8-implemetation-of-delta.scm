
;; From 1.22 we can use a derivative to get an analytical version without
;; needing to implement taking limits.
(define (((delta eta) f) q)
  (define ((((g eta) f) q) eps)
    (f (+ q (* eps eta))))
  ((D (((g eta) f) q)) 0))

(define (f q)
  (compose
   (literal-function 'F
                     (-> (UP Real (UP* Real) (UP* Real)) Real))
   (Gamma q)))

(define (g q)
  (compose
   (literal-function 'G
                     (-> (UP Real (UP* Real) (UP* Real)) Real))
   (Gamma q)))

(define q (literal-function 'q (-> Real (UP Real Real))))
(define eta (literal-function 'eta (-> Real (UP Real Real))))

(define (variation-on-path func path) (((delta eta) func) path))
(define (print-t func) (print-expression (func 't)))

;; 1.23
(print-t (- (variation-on-path (* f g) q)
            (+ (* (variation-on-path f q) (g q))
               (* (f q) (variation-on-path g q)))
            )
         )

;;1.24
(print-t (- (variation-on-path (+ f g) q)
            (+ (variation-on-path f q)
               (variation-on-path g q)))
         )

;; 1.25
(print-t (- (variation-on-path (* 'c f) q)
            (* 'c (variation-on-path f q)))
         )

;; 1.26
(define F (literal-function 'F (-> Real Real)))
(define (h q) (compose F (g q)))

(print-t (- (variation-on-path h q)
            (* (compose (D F) (g q))
               (variation-on-path g q)))
         )

;; 1.27

(define (Df q) (D (f q)))
(print-t (- (D (variation-on-path f q))
            (variation-on-path Df q)))
