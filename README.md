beautipoll
==========

Phase 2, Week 2 project to create a web app similar to SurveyMonkey


Possible features to implement:

1) Refactor application.js
  - Split into multiple files
  - Use HTML templates/partials so that HTML doesn't live inside JavaScript
  - Implement control flow logic for editing questions, rather than the current implementation
    > One question modal rather than two. 

2) Improve implementation of Bootstrap
  - Make sure HTML does not contain styling!

3) Save on loss-of-focus when taking a survey

4) Implement more types of questions (photos?), and make drag & drop work (currently works only when creating (easy fix))
  - Drag & Drop requires saving the position of the DOM element, among others. 

5) Properly implement Delete button next to each choice when creating questions (app is functional without this)

6) Create a nice visual interface for viewing survey results

7) Implement OAuth authentication (GitHub, Facebook, Twitter, etc.)

8) Use Filepicker.io to store survey images in Amazon S3. 

9) Allow user to re-order questions (with drag & drop)

10) Text input fields (first option in drop-down) does not function correctly when taking a survey (check naming)
