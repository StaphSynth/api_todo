import PropTypes from 'prop-types';
import React from 'react';
import Task from './Task';

const TaskList = ({ tasks }) => {
  <ul>
    { buildList(tasks) }
  </ul>
};

const buildList = (tasks) => {
  tasks.map((task, i) => (
    <Task
      key={ i }
      { ...task }
    />
  ));
};

TaskList.PropTypes = {
  tasks: PropTypes.arrayOf(
    PropTypes.shape({
      id: PropTypes.number.isRequired,
      complete: PropTypes.bool.isRequired,
      text: PropTypes.string.isRequired,
      priority: PropTypes.string.isRequired
    }).isRequired
  ).isRequired
};

export default TaskList;
