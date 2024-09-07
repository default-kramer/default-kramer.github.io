#lang scribble/manual

@(require scribble/examples
          "helpers.rkt"
          (for-label racket hermits-heresy))

@title{Tutorial: Mottled Footpath}
Too random?
Not random enough?
If I create a mottled footpath by hand, this question can haunt me for weeks.
Better to use Hermit's Heresy to generate a truly random one, and then make manual
adjustments only where something obviously offends my taste.

This tutorial is standalone and can be done on any island,
but can also be treated as a continuation of
@link["mottled-mountainside.html"]{the Mottled Mountainside tutorial}.

First we need to decide on a placeholder block which we know is not being used elsewhere.
I choose the Seaside Scene block and know it is unused because I am on a fresh Buildertopia.
Now use the trowel (or any technique of your choice) to define where the path should go:
@(img "mottled-footpath/placeholder-path.png")

Save your game and exit.
Now we just need a script to perform the replacement.
The script starts with the usual setup.
Change these values as needed:
@(racketblock
  #,(tt "#lang racket")
  (require hermits-heresy)
  (save-dir "C:/Users/kramer/Documents/My Games/DRAGON QUEST BUILDERS II/Steam/76561198073553084/SD/")
  (define source-slot 'B02) (code:comment "slot 3")
  (define dest-slot 'B00) (code:comment "slot 1, my ephemeral slot")
  (define stage-id 'BT1) (code:comment "Buildertopia 1"))

Next we use @(racket build-mottler) to define the mottling we want.
If you don't understand this code, it is explained in
@link["mottled-mountainside.html"]{the Mottled Mountainside tutorial}.
I encourage you to adjust the blocks and weights to your taste:
@(racketblock
  (define path-mottler
    (build-mottler '[Grassy-Earth 1]
                   '[Limegrassy-Earth 1]
                   '[Mossy-Earth 1]
                   '[Earth 1]
                   '[Stony-Soil 2]
                   '[Siltstone 2])))

Next we define a simple traversal.
When this traversal sees the Seaside Scene block it will replace it with a
block from the @(racket path-mottler) we defined earlier:
@(racketblock
  (define trav
    (traversal
     (cond
       [(block-matches? 'Seaside-Scene-Block)
        (set-block! (path-mottler))]))))

And now we just have to execute the traversal.
As usual, I first copy from my source save slot to my ephemeral save slot.
Then I make the modifications to the ephemeral slot.
Doing it this way means if I don't like the result, I can easily adjust the script
and rerun it because my source save slot has not changed.
@(racketblock
  (copy-all-save-files! #:from source-slot #:to dest-slot)
  (define stage (load-stage stage-id dest-slot))
  (traverse stage trav)
  (save-stage! stage))

Here is the result:
@(img "mottled-footpath/overhead-path-earthy.png")

Hmm, I don't like the way the path looks when it is adjacent to bare Earth.
It doesn't contrast well enough.
So I'll do a little manual trowel work to fix that:
@(img "mottled-footpath/overhead-path-grassy.png")

Okay, that should be good enough for now.
Here is the complete script:
@(racketblock
  #,(tt "#lang racket")
  (require hermits-heresy)
  (save-dir "C:/Users/kramer/Documents/My Games/DRAGON QUEST BUILDERS II/Steam/76561198073553084/SD/")
  (define source-slot 'B02) (code:comment "slot 3")
  (define dest-slot 'B00) (code:comment "slot 1, my ephemeral slot")
  (define stage-id 'BT1) (code:comment "Buildertopia 1")

  (define path-mottler
    (build-mottler '[Grassy-Earth 1]
                   '[Limegrassy-Earth 1]
                   '[Mossy-Earth 1]
                   '[Earth 1]
                   '[Stony-Soil 2]
                   '[Siltstone 2]))

  (define trav
    (traversal
     (cond
       [(block-matches? 'Seaside-Scene-Block)
        (set-block! (path-mottler))])))

  (copy-all-save-files! #:from source-slot #:to dest-slot)
  (define stage (load-stage stage-id dest-slot))
  (traverse stage trav)
  (save-stage! stage))

Good luck on the path.
@(img "mottled-footpath/good-luck-on-the-path.png")
