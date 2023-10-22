# To-Do App

 <h1>Introduction</h1>
 
  The problem that I am trying to solve is feeling unorganized and lost while doing daily tasks. A to-do application can allow the customer to keep track of daily tasks and feel more organized. After checking completed tasks from the to-do list, they will also feel a sense of accomplishment.
 
  <h1>Features</h1>
 
  - Users can create their own tasks by clicking on the '+' buttons.
  - You can mark a task as done by clicking on it (check it).
  - When creating a task you may choose to add a deadline, including only a date or a date and a time.
  - You can edit tasks by clicking on the pen button.
  - You can delete a task by sliding it from right to left.
 
  <h1>Possible features</h1>
  
  - Use SQLite to store tasks.
  - User could add more than one list.
  - User could receive a push-up when a task is expired.
  - Users could change the color scheme of the app.

  <h1>App Architecture</h1>

  The app follows the Provider pattern for state management. This allows for efficient and organized data flow throughout the app. The main components include:
  
  - Models: Define the data structures used in the app.
  - Providers: Manage the app's state and business logic.
  - Screens: Represent the main UI components and are where users interact with the app.

  <h1>Data Flow</h1>
  
  - Task Creation: When a task is created in the AddTaskScreen, it's added to the TaskProvider.
  - Task Display: The HomePage listens to changes in the TaskProvider and updates the UI accordingly.
  - Task Modification: Tasks can be edited or deleted, and these changes are reflected in the TaskProvider and subsequently in the UI.