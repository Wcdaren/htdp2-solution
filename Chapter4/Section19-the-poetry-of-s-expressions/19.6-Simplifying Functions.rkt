;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |19.6-Simplifying Functions|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; data difinitions
; An Atom is one of: 
; – Number
; – String
; – Symbol


; An S-expr is one of: 
; – Atom
; – SL


; An SL is one of: 
; – '()
; – (cons S-expr SL)


;; functions
; S-expr Symbol Atom -> S-expr
; replaces all occurrences of old in sexp with new
 
(check-expect (substitute '(((world) bye) bye) 'bye '42)
              '(((world) 42) 42))
(check-expect (substitute '(((world) hello) bye) 'world "world")
              '((("world") hello) bye))
(check-expect (substitute '(define no-parent "") 'define 'define-struct)
              '(define-struct no-parent ""))
(check-expect (substitute '(((hello) world) goodbye) 'world 'sekai)
              '(((hello) sekai) goodbye))
(check-expect (substitute 123 'hello 'hi)
              123)
(check-expect (substitute "hello" 'hello 'hi)
              "hello")
(check-expect (substitute '(((world) hello) hello) 'hello 'hi)
              '(((world) hi) hi))
 
(define (substitute sexp old new)
  (cond [(atom? sexp) (if (equal? sexp old) new sexp)]
        [else (map (lambda (s) (substitute s old new)) sexp)]))


;; auxiliary functions
; X -> Boolean
; determine whether the given x is an Atom.

(check-expect (atom? 100) #true)
(check-expect (atom? "hello") #true)
(check-expect (atom? 'a) #true)
(check-expect (atom? #false) #false)

(define (atom? x)
  (or (number? x)
      (string? x)
      (symbol? x)))


;; Questions
;; Q1: Explain why we had to use lambda for this last simplification?
;; A1: Because the function use local may be expensive.


