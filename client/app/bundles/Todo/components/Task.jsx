import React from 'react';

const Task = (task) => (
  <div className='task'>
    <span className='priority'>{ task.priority }</span>
    <TaskText text={ task.text } />
    <Complete complete={ task.complete } />
  </div>
);

const Complete = ({ complete }) => (
  <div className='task-complete'>
    <input
      className='complete'
      type='checkbox'
      name='complete'
      value='complete'
      defaultChecked={ complete }
    />
  </div>
);

const TaskText = ({ text }) => (
  <div className='task-text'>{ text }</div>
);

const Priority = ({ priority }) => (
  <div className='task-priority'>
    <TaskText text={ priority } />
  </div>
);

export default Task;
