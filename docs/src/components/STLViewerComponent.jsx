import React from 'react';
import { StlViewer } from 'react-stl-viewer';

const style = {
    width: '100vw',
    height: '100vh',
    backgroundColor: '#f0f0f0',
};

export default function STLViewerComponent({ url }) {
    return (
        <div>
            <StlViewer
                url={url}
                style={style}
                orbitControls                // ← включает вращение/зум
                shadows = {true}                     // тени на “пол”
                showAxes = {true}  
                modelProps={{
                    color: "#8FFE34",
                    scale: 4
                }}
                cameraProps={{
                    initialPosition: {
                        latitude: 0.5,
                        longitude: 1.3,
                        distance: 5.0,    
                    }
                }}
                rotate={true}
            />
        </div>
    );
}
