# Proposal

### What will (likely) be the title of your project?

Scriabin: Sonic Paintings

### In just a sentence or two, summarize your project. 

An iOS-based application that allows users to paint and compose music simultaneously based on Alexander Scriabin's Synesthetic Circle of Fifths 
### In a paragraph or more, detail your project. What will your software do? What features will it have? How will it be executed?

IDEA: The app starts by displaying a selection menu where the user finds X number of different key options (from 5-12). Once the user selects one, the background becomes the color associated to the selected key (based on Scriabin’s Circle of Fifths) and a drone of the tonic starts playing. 

Time to compose!

If user draws a positive line in the x axis: ascending major scale plays as the line is drawn


If user draws a negative line in the x axis: 
Descending major scale

If user draws a positive line in the y axis: 
Ascending minor scale

If user draws a negative line in the y axis: 
Descending minor scale 

If user presses the screen (z is measured based on the amount of time the screen is being pressed): 
Random sequence between 1, 2, b3, 3, 4, 5, b6, 6, b7, 7

Once composition is done the user has the option of saving his/her composition both as an image and audio file. Then the program redericts the user to the key options menu. (Now a "My Work" folder is enabled)

 

//In the future it could be cool to save it as a video


Implementation: 

Navegation: It starts with a view containing buttons (keys) that take the user to another view through navegation controller. The "My Work" and "Key/Color Selection" Button would be based on tab controller. 

Drawing will be created using circles and Audiokit OscillatorBank (in order to work based on midi notes and not pitch). It will use Multitouch technology. 

To save compositions: .exportAsynchronously












### In the world of software, most everything takes longer to implement than you expect. And so it's not uncommon to accomplish less in a fixed amount of time than you hope.

#### In a sentence (or list of features), define a GOOD outcome for your final project. I.e., what WILL you accomplish no matter what?

5-6 Keys/Colors, major and minor scales work, compositions can be saved

#### In a sentence (or list of features), define a BETTER outcome for your final project. I.e., what do you THINK you can accomplish before the final project's deadline?

8-10 Keys/Colors, major, minor and random scales/sequences work, compositions can be saved and reproduced/

#### In a sentence (or list of features), define a BEST outcome for your final project. I.e., what do you HOPE to accomplish before the final project's deadline?

12 Keys/Colors, all modes can be played in order or in random ways, compositions can be saved and reproduced, compositions can be shared.

### In a paragraph or more, outline your next steps. What new skills will you need to acquire? What topics will you need to research?

Next Steps: Create UI of the entire experience to get a sense of the navegation and logic. Then, implement the useful parts of code of the Multitouch and AudioRecorder Problem Sets. Finally start researching about those things that remain uncertain.

Topics to Research: First, I need to familiarize more with AudioKit (specially with the OscillatorBank) in order to be able to generate the desired modes. Then, I need to understand how to manage data (saving and exporting the compositions). Finally, I need to explore the possible ways of drawing (maybe using an specific framework for that?)

Skills: More Swift practice, use of frameworks and troubleshooting (learn to deal with errors).
