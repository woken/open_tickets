class ChosenTagSelect extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      tags: props.tags || [],
      _selected: props._selected || []
    };

    channelTag = new EventBroker;
    channelTag.create('selectChosenTag');
    channelTag.subscribe('selectChosenTag', (function(newTag) {
      this.state.tags.push(newTag)
      this.state._selected.push(newTag.id)

      this.setState({
        tags: this.state.tags,
        _selected: this.state._selected
      });
    }).bind(this));
  }

  componentDidMount() {
    $('.chosen-select').change((function(event) {
      selected = [];
      for(i = 0; i < event.target.selectedOptions.length; i++) {
        selected.push(event.target.selectedOptions[i].value)
      }

      this.setState({ _selected: selected });
    }).bind(this));
  }

  componentDidUpdate() {
    $('.chosen-select').trigger("chosen:updated");
  }

  handleChange() {}

  render() {
    return (
      <select value={this.state._selected} onChange={this.handleChange.bind(this)} className={this.props.klass} multiple={true} name={this.props.model + '[' + this.props.attr + '][]'} id={this.props.model + '_' + this.props.attr}>
        {
          this.state.tags.map(function(tag, index) {
            return (<option key={'tag-option' + index} value={tag.id}>{tag.name}</option>)
          })
        }
      </select>
    );
  };
}

ChosenTagSelect.propTypes = {
  tags: React.PropTypes.array,
  _selected: React.PropTypes.array,
  model: React.PropTypes.string,
  attr: React.PropTypes.string,
  klass: React.PropTypes.string
};
