/**
 * Created by divine on 2016/06/17.
 */
import React, {Component} from 'react'

class MyApp  extends  Component  {

    constructor(props) {
        super(props)

        this.state = { name : props.name}
    }

    render() {
        return (<div>
            hello, {this.state.name}
        </div>);
    }
}

export default MyApp;

