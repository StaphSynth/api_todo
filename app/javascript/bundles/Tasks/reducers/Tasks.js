const tasks = (state = [], action) => {
  switch(action.type) {
    case 'ADD_TASK':
      return [...state, action.task];
    case 'TOGGLE_TASK':
      return state.map(task => {
        task.id === action.id ? {...task, complete: !task.complete } : task;
      });
    default:
      return state;
  }
};

export default tasks;
