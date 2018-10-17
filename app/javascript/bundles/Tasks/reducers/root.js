import tasks from './tasks';
import visibilityFilter from './visibilityFilter';
import { combineReducers } from 'redux';

const rootReducer = combineReducers({ tasks, visibilityFilter });

export default rootReducer;