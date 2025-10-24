import React, { useCallback, useRef } from 'react';
import { StlViewer } from 'react-stl-viewer';

const style = {
    width: '100vw',
    height: '100vh',
    backgroundColor: '#f0f0f0',
};


export default function STLViewerComponent({ url }) {
    const cameraRef = useRef(null);
    const handleLoaded = useCallback((dim) => {
        console.log("handle loaded");

        if (!cameraRef.current || !cameraRef.current.setCameraPosition) return;

        console.log("camera loaded");
        
        const distance = dim.boundingRadius * 2;

        const distance1 = 20;
        
        console.log("distance", distance, cameraRef.current);
        
        cameraRef.current.setCameraPosition({
            latitude: 0.9,   
            longitude: 0.8,  
            distance: distance1,        
        });
    }, []);

    return (
        <div>
            <StlViewer
                url={url}
                style={style}
                orbitControls                // ← включает вращение/зум
                shadows = {true}                     // тени на “пол”
                showAxes = {true}  
                modelProps={{
                    color: "#f4ab22",
                    scale: 1
                }}
                cameraProps={{
                    ref: cameraRef,
                    initialPosition: { 
                        latitude: 0.9, 
                        longitude: 0.2,
                        distance: 3
                    },
                }}
                //rotate={true}
                onFinishLoading={handleLoaded}
            />
        </div>
    );
}
