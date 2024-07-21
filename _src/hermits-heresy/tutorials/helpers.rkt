#lang racket

(provide img examples-no-eval)

(require scribble/core
         scribble/manual
         scribble/example
         racket/runtime-path)

(define-runtime-path images-dir "images")

; The style name becomes the CSS class
(define image-style (style "hh-scribble-image" (list)))

(define (img path)
  (image (build-path images-dir path) #:style image-style))

; Racketblock can't show the #lang line, so we trick examples into not evaluating anything:
(define-syntax-rule (examples-no-eval arg ...)
  (parameterize ([scribble-eval-handler
                  (lambda (a b c) (void))])
    (examples arg ...)))
