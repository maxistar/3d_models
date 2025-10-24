import React, { useState } from 'react';
import { StlViewer } from 'react-stl-viewer';

const viewerStyle = {
    width: '100%',
    height: '500px',
    backgroundColor: '#f0f0f0',
    borderRadius: '8px',
    overflow: 'hidden',
    border: '1px solid #ccc',
};

const listWrapperStyle = {
    marginTop: '1rem',
    display: 'flex',
    flexWrap: 'wrap',
    gap: '0.5rem',
};

const itemButtonStyle = (active) => ({
    cursor: 'pointer',
    borderRadius: '6px',
    padding: '0.5rem 0.75rem',
    fontSize: '0.9rem',
    lineHeight: 1.2,
    border: active ? '2px solid #2563eb' : '1px solid #999',
    backgroundColor: active ? '#dbeafe' : '#fff',
    color: active ? '#1e3a8a' : '#333',
});

export default function STLViewerGallery({ urls }) {
    // fallback на случай пустого массива
    const validUrls = Array.isArray(urls) ? urls : [];
    const [currentIndex, setCurrentIndex] = useState(0);

    if (validUrls.length === 0) {
        return <div>Нет STL-файлов для отображения</div>;
    }

    const currentUrl = validUrls[currentIndex];

    return (
        <div>
                <StlViewer
                    url={currentUrl}
                    style={viewerStyle}
                    orbitControls      // вращение/зум мышью
                    shadows            // мягкие тени на плоскости
                    showAxes           // показать оси X/Y/Z
                    cameraProps={{
                        initialPosition: {
                            latitude: 0.9,
                            longitude: 0.2,
                            distance: 3
                        },
                    }}
                    modelProps={{ color: '#f4ab22' }} // можешь включить кастомный цвет модели
                />

            {/* Список моделей */}
            <div style={listWrapperStyle}>
                {validUrls.map((u, i) => {
                    // имя файла без пути — чисто косметика
                    const label = u.split('/').pop() || `Model ${i + 1}`;

                    return (
                        <button
                            key={u + i}
                            type="button"
                            style={itemButtonStyle(i === currentIndex)}
                            onClick={() => setCurrentIndex(i)}
                        >
                            {label}
                        </button>
                    );
                })}
            </div>
        </div>
    );
}
