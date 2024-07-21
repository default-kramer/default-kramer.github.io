#lang scribble/manual

@(require scribble/examples
          "helpers.rkt"
          (for-label racket hermits-heresy))

@title{Tutorial: Basic Hill}
This example uses @hyperlink["https://www.getpaint.net/download.html"]{paint.net}.
You will need to download and install it to follow along.
(You may also be able to use a different image editor of your choice.)

@bold{Important!} When using paint.net, you almost always want "Aliased rendering" enabled.
This setting does not apply to some tools (like the Pencil) but it does apply to others (like the Paint Bucket).
If you see weird results, especially at borders, check to make sure you used Aliased rendering:
@;(img "img/basic-hill-1/alias-setting.png")
@(img "basic-hill-1/alias-setting.png")

@section{Step 1 - Setup}
Create a new directory for this project.
Add a file @italic{script.rkt} in that directory.
Paste this content into @italic{script.rkt} and run it.
@(examples-no-eval
  #:lang racket
  (require hermits-heresy)
  (save-template-image 'IoA-background)
  (save-template-image 'IoA-mask))

You should see some output like the following:
@(racketblock "wrote to C:\\Users\\kramer\\Desktop\\basic-hill\\IoA-background.bmp"
              "wrote to C:\\Users\\kramer\\Desktop\\basic-hill\\IoA-mask.bmp")

Import both of these images into a new paint.net project.
Save that project as @italic{plan.pdn}.
It should look something like this:
@(img "basic-hill-1/initial-plan.png")

The IoA-background image may help guide you while drawing your hill.
The IoA-mask image blacks out areas which cannot be built on.

@section{Step 2 - Draw your Hill}
Create a new layer in paint.net and draw a filled-in shape where you want your hill to be.
I used the Pencil and the Paint Bucket tools to draw a huge red hill covering much of the west side of the map:
@(img "basic-hill-1/added-red-hill.png")

And because I'm feeling fancy, I'm going to add another layer and draw a smaller yellow hill
on top of the red hill.
You don't have to do this, but I think it improves the demonstration:
@(img "basic-hill-1/added-yellow-hill.png")

Now you need to export your hill in a format that Hermit's Heresy can understand.
First, toggle the IoA-mask and IoA-background Layers visibility to off, because
we don't want these in the output.
Now use File -> Save As to save just the hill data as a bitmap named @italic{hill.bmp}.
Paint.net will allow you to adjust some settings like Bit Depth but I always just take the defaults.
You do have to Flatten the image to save as a bitmap, which is what we want anyway.
Now your paint.net should look something like this:
@(img "basic-hill-1/flattened-bmp.png")

Finally, we need to color the hill to communicate the elevation.
You can read the documentation of @(racket bitmap->hill) for more details, but basically
darker pixels correspond to taller elevation.
I paint the larger area with rgb(80,80,80) meaning it will be 40 blocks short of max height.
I paint the smaller area with rgb(20,20,20) meaning it will be 10 blocks short of max height.
I adjusted the Tolerance of the Paint Bucket down to 0% to avoid leaking from one section to the other.
The result looks like this:
@(img "basic-hill-1/colored-bmp.png")

Also pay attention that the background is fully transparent.
If you got a white background by accident, you can use the Magic Wand to select and delete the white pixels.

@section{Step 3 - Place the Hill}
Switch back to Racket, opening @italic{script.rkt} if you don't already have it open.
We no longer need the @(racket save-template-image) stuff, so remove those lines.
The file should now contain only these two lines:
@(examples-no-eval
  #:lang racket
  (require hermits-heresy))

Now we are going to add a few more lines, and I will explain what each does.
First, you need to tell Hermit's Heresy where your SD directory is.
Adjust the following line as needed.
@(racketblock
  (save-dir "C:/Users/kramer/Documents/My Games/DRAGON QUEST BUILDERS II/Steam/76561198073553084/SD/"))

Now choose your source and destination save slots.
Your destination slot must be configured as writable as per
@hyperlink["https://docs.racket-lang.org/hermits-heresy/index.html#%28part._make-slot-writable%29"]{the installation instructions}.
@(racketblock
  (define source-slot 'B02)
  (define dest-slot 'B00))

The following line copies everything from the source to the destination.
@(racketblock
  (copy-all-save-files! #:from source-slot #:to dest-slot))

The following line loads the stage to be edited.
@(racketblock
  (define stage (load-stage 'IoA dest-slot)))

The following line reads the @italic{hill.bmp} you created.
@(racketblock
  (define hill (bitmap->hill "hill.bmp")))

The following line fills the blockspace defined by the hill with Chert.
If you want to use a different block, look up its Id in
@hyperlink["https://github.com/Sapphire645/DQB2ChunkEditorPlus/blob/main/src/Data/Tiles.json"]{this file}
and replace @(racket (block 'Chert)) with that number.
(This will be improved soon.)
@(racketblock
  (put-hill! stage hill (block 'Chert)))

And finally, the following line saves the stage back to the filesystem.
@(racketblock
  (save-stage! stage))

And that's it!
The complete script should look approximately like this:
@(examples-no-eval
  #:lang racket
  (require hermits-heresy)

  (save-dir "C:/Users/kramer/Documents/My Games/DRAGON QUEST BUILDERS II/Steam/76561198073553084/SD/")
  (define source-slot 'B02)
  (define dest-slot 'B00)

  (copy-all-save-files! #:from source-slot #:to dest-slot)

  (define stage (load-stage 'IoA dest-slot))

  (define hill (bitmap->hill "hill.bmp"))
  (put-hill! stage hill (block 'Chert))

  (save-stage! stage))

Run the script in DrRacket, and you should see output like this:
@(racketblock
  "Copied 14 files from [...] to [...]"
  "put-hill! placed 6712199 blocks, left 1705 items intact"
  "Saved STGDAT file: C:/Users/.../SD/B00/STGDAT01.BIN")

Over 6 million blocks placed!
Sure beats doing it by hand if you ask me.

@section{Step 4 - Validate Results}
Start up DQB2 and load your save.
Take a look around and verify that it did what you want.
If not, loop back to step 2, adjust your drawings and/or your script, and repeat.
Here is a look at my hill, at the east side looking west:
@(img "basic-hill-1/result-angle-1.png")

And here is another angle, showing the back where I configured the two different elevations:
@(img "basic-hill-1/result-angle-2.png")

This example is also available
@hyperlink["https://github.com/default-kramer/HermitsHeresy/tree/main/examples/basic-hill"]{on Github}.

Continued at @hyperlink["basic-hill-2.html"]{Part 2}.