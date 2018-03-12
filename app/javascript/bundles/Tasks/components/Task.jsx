import React from 'react';
import PropTypes from 'prop-types';

const Task = ({ complete, priority, text }) => (
  <li>
    <div className='task'>
      <span className='priority'>{ priority }</span>
      <TaskText text={ text } complete={ complete } />
      <Complete complete={ complete }/>
    </div>
  </li>
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

const TaskText = ({ text, complete }) => (
  <div
    className='task-text'
    style={ { textDecoration: complete ? 'line-through' : 'none' } }>
    { text }
  </div>
);

const Priority = ({ priority }) => (
  <div className='task-priority'>
    { priority }
  </div>
);

// const updateComplete = (event) => {
//   try {
//     let response = await fetch(`/api/v1/tasks/1`,
//       {
//         method: 'PUT',
//         headers: { 'Content-Type': 'application/json' },
//         body: JSON.stringify({ complete: false })
//       }
//     );
//
//     let myData = await response.json();
//   } catch ( err ) {
//
//   }
// };

Task.PropTypes = {
  priority: PropTypes.string.isRequired,
  complete: PropTypes.bool.isRequired,
  text: PropTypes.string.isRequired
};

export default Task;
