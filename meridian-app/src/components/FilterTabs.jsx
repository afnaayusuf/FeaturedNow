import React, { useState } from 'react';
import './FilterTabs.css';

const TABS = ['All', 'Following', 'Gradient', 'Bare Metal', 'Convenes', 'Vault'];

export default function FilterTabs() {
  const [activeTab, setActiveTab] = useState('All');

  return (
    <>
      <div className="filter-row">
        {TABS.map(tab => (
          <button
            key={tab}
            className={`filter-tab ${activeTab === tab ? 'active' : ''}`}
            onClick={() => setActiveTab(tab)}
          >
            {tab}
          </button>
        ))}
      </div>
      <div className="nav-divider"></div>
    </>
  );
}
