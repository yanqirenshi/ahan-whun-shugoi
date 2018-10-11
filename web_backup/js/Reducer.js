class Reducer extends Vanilla_Redux_Reducer {
    isMergeActionTypes (action_type) {
        return [
            'MOVE-PAGE',
            'FETCHED-COMMANDS',
            'FETCHED-SUBCOMMANDS',
            'FETCHED-SUBCOMMAND',
            'FETCHED-COMMAND',
            'FETCHED-AWS',
            'FETCHED-OPTION',
            'FETCHED-AWS_OPTIONS',
            'FETCHED-COMMAND_SUBCOMMANDS',
            'SWITCH-SELECTOR',
            'UPDATED-COMMAND-DISPLAY',
            'FETCHED-COMMAND-4-SELECTOR',
            'UPDATE-SELECTOR-SERCH-WORKD-4-COMMANDS',
            'UPDATE-SELECTOR-ELEMENT-KEWORD',
            'FETCHED-FINDERS',
            'UPDATED-FINDER-LOOK-AT',
            'UPDATED-FINDER-SCALE',
            'CLICK-FINDER',
            'LOADED-EC2-INSTANCES'
        ].find(function (v) {
            return v==action_type;
        }) ;
    }
    put (state, action) {
        return this.isMergeActionTypes(action.type) ?
            this.merge(state, action.data) : state;
    }
}