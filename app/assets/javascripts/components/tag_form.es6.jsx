class ModalTagForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = { errors: [], name: null };
  };

  handleClick(event) {
    if(this.state.name) {
      var _this = this;
      $.ajax({
        type: "POST",
        url: '/tags',
        data: {
          tag: {
            name: this.state.name
          }
        },
        dataType: "JSON",
        success: function(newTag, status, response) {
          _this.setState({ errors: [], name: null });
          $('#new_tag').modal('toggle');
          channelTag.publish('selectChosenTag', newTag);
        },
        error: function(response, status, exception) {
          _this.setState({errors: response.responseJSON.name})
        }
      });
    } else {
      this.setState({errors: ['Insert a tag name']})
    }
  };

  handleChange(event) {
    this.setState({ name: event.target.value })
  }

  render() {
    var style = 'collapse';
    if (this.state.errors.length > 0) style = '';

    return (
      <div className="modal" id="new_tag" style={{display: 'none'}}>
        <div className="modal-dialog">
          <div className="modal-content">
            <div className="form-horizontal">
              <div className="modal-header">
                <button aria-hidden="true" className="close" data-dismiss="modal" type="button"> ×</button>
                <h4 className="modal-title">
                  Create Tag
                </h4>
              </div>
              <div className="modal-body">
                <br />
                <div className={'alert alert-dismissible alert-danger ' + style}>
                  <ul>
                    {
                      this.state.errors.map(function(error, index) {
                        return (
                          <li>{error}</li>
                        )
                      })
                    }
                  </ul>
                </div>
                <fieldset>
                  <div className="form-group">
                    <label className="col-xs-3 control-label" htmlFor="ticket_issue_type_id">Name</label>
                    <div className="col-xs-9">
                      <input onChange={this.handleChange.bind(this)} className="form-control" value={this.state.name} type="text" name="tag[name]" id="tag_name" />
                    </div>
                  </div>
                </fieldset>
              </div>
              <div className="modal-footer">
                <button className="btn btn-info" data-dismiss="modal" type="button"> Close</button>
                &nbsp;
                <button className="btn btn-primary" type="button" onClick={this.handleClick.bind(this)}>Create</button>
              </div>
            </div>
          </div>
        </div>
      </div>
    );
  };
}
