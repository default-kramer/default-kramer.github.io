# STB - Defining the Perimeter
**WARNING** - This page demonstrates the use of some **undocumented and unstable functionality**.
If you are interested using any of these functions yourself, let me know and I will prioritize making them stable and documented.

My [Study the Blade](/stb/) project is an "ongoing project", meaning that my workflow goes like this:

1. Do some manual building (possibly for months at a time)
2. Run a Hermit's Heresy script to generate terrain
3. Check out the result. As desired, adjust the images and/or scripts and loop back to step 2.
4. Is the island complete? Probably not, so discard the generated terrain and loop back to step 1. Keep the scripts of course, for future generations.

I use Save Slot 3 for my manual building, and Save Slot 1 for the temporary generated output.
(Save Slot 1 is my ephemeral slot.)

In order to support this workflow, I need a way to tell Hermit's Heresy not to overwrite anything in the manual build area.
I do this by hiding a layer of Seaweed-Styled Block underneath the manual build area.
(Any block that does not occur naturally would be a good choice.)
You can see the Seaweed platform below.
The Herringbone Floorboard is just outside the manual build area and will be overwritten when the script runs:

![The STB Perimeter](/img/STB/perimeter1.jpg)

I use the undocumented function `stage->pict` to generate an image of my manual build area.
This allows me to use paint.net to confirm that everything looks as expected.

![Manual Build Sanity Check](/img/STB/manual-build-sanity-check.png)

And then I use the undocumented `with-protected-areas` to tell Hermit's Heresy to leave that manual build area untouched when I run the script.

![Perimeter After Generation](/img/STB/perimeter2.jpg)

The full project is [available on Github](https://github.com/default-kramer/HermitsHeresy/blob/main/examples/STB/stb.rkt)
but I will repeat: most of this functionality is undocumented and unstable, so I don't recommend starting an "ongoing project" like this
right now unless you don't mind the potential for breaking changes.
