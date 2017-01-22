;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex449-change-find-root) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define ε 0.0001)


;; functions
; [Number -> Number] Number Number -> Number
; determine R such that f has a root in [R, (+ R ε)]
; assume f is continuous
; (2) (or (<= (f left) 0 (f right)) (<= (f right) 0 (f left)))
; generative divide interval in half, the root is in
; one of the two halves, pick according to (2)

(check-satisfied (find-root poly 3 10) (check-root poly))
(check-satisfied (find-root poly -10 3) (check-root poly))

(define (find-root f left right)
  (find-root/auxi f left right (f left) (f right)))


; [Number -> Number] Number Number Number Number -> Number
; determine R such that f has a root in [R, (+ R ε)]
; assume f is continuous
; (2) (or (<= (f left) 0 (f right)) (<= (f right) 0 (f left)))
; generative divide interval in half, the root is in
; one of the two halves, pick according to (2)
; add two boundary value of the function.

(define (find-root/auxi f left right f@left f@right)
  (cond [(<= (- right left) ε) left]
        [else (local ((define mid (/ (+ left right) 2))
                      (define f@mid (f mid)))
                (cond [(or (<= f@left 0 f@mid)
                           (<= f@mid 0 f@left))
                       (find-root/auxi f left mid f@left f@mid)]
                      [(or (<= f@mid 0 f@right)
                           (<= f@right 0 f@mid))
                       (find-root/auxi f mid right f@mid f@right)]))]))


;; check-function
; Number -> Number

(check-expect (poly 5) 3)
(check-expect (poly 10) 48)
(check-expect (poly 2) 0)
(check-expect (poly 4) 0)

(define (poly x)
  (* (- x 2)
     (- x 4)))


; [Number -> Number] -> [Number -> Boolean]
; produces a function which determine the given value
; is near the root of f.

(define (check-root f)
  (local ((define PRECSION 0.05)
          ; Number Number -> Boolean
          ; determine whether (abs num) sub 0 is less than acc.
          (define (in-range num acc)
            (>= acc (- (abs num) 0))))
    (lambda (value) (in-range (f value) PRECSION))))


;; Questions
;; Q1: How many re-computations of (f left) does this design
;; maximally avoid?
;;
;; A1: One recursive call will save 1 time re-computation (after variable hositing),
;; there may be more than 30+ call per time, so the max maybe 30+.