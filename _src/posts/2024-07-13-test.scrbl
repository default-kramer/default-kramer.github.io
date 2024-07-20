#lang scribble/manual

Title: A Scribble Post
Date: 2024-07-13T00:00:00
Tags: Racket, blogging

@(require (for-label racket hermits-heresy doc-coverage))

Scribble still feels like it's from 20 years in the future.

@(racketblock
  (void check-all-documented 56)
  (let ([x (block 99)])
    (put-hill! a b x)))
