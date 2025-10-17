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
                orbitControls                // ← включает вращение/зум
                shadows                      // тени на “пол”
                showAxes                     // оси X/Y/Z
                cameraProps={{               // подстрой стартовой камеры
                    position: [2, 2, 2],       // подвинь при необходимости
                    fov: 50
                }}
                modelColor="#B92E34"
                backgroundColor="#EAEAEA"
                rotate={true}
            />
        </div>
    );
}
