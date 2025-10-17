import React from 'react';
import { StlViewer } from 'react-stl-viewer';

const style = {
    width: '100%',
    height: '400px',
    backgroundColor: '#f0f0f0',
};

export default function STLViewerComponent({ url }) {
    return (
        <div style={style}>
            <StlViewer
                url={url}
                modelColor="#B92E34"
                backgroundColor="#EAEAEA"
                rotate={true}
            />
        </div>
    );
}
