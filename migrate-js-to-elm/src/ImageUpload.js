import React, { Component } from 'react';
import { Elm } from './ImageUpload.elm';
import './ImageUpload.css';

const IMAGE_UPLOADER_ID = 'field-upload';

class ImageUpload extends Component {
  constructor(props) {
    super(props);
    this.elmRef = React.createRef();
    this.readImages = this.readImages.bind(this);
  }

  componentDidMount() {
    this.elm = Elm.ImageUpload.init({
      node: this.elmRef.current,
      flags: {
        imageUploaderId: IMAGE_UPLOADER_ID,
        images: this.props.images,
      }
    });
    this.elm.ports.uploadImages.subscribe(this.readImages);
  }

  componentDidUpdate() {
    this.elm.ports.receiveImages.send(this.props.images);
  }

  componentWillUnmount() {
    this.elm.ports.uploadImages.unsubscribe(this.readImages);
  }

  readImage(file) {
    const reader = new FileReader();
    const promise = new Promise((resolve) => {
      reader.onload = (e) => {
        resolve({
          url: e.target.result,
        });
      };
    });
    reader.readAsDataURL(file);
    return promise;
  }

  readImages() {
    const element = document.getElementById(IMAGE_UPLOADER_ID);
    const files = Array.from(element.files);

    Promise.all(files.map(this.readImage))
      .then(this.props.onUpload);
  }

  render() {
    return <div ref={this.elmRef} />
  }
}

export default ImageUpload;
