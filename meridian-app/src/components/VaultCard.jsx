import React from 'react';
import './VaultCard.css';

export default function VaultCard({ title, meta, tags }) {
  return (
    <div className="vault-card">
      <div className="vault-icon">
        <svg width="20" height="20" viewBox="0 0 20 20" fill="none">
          <rect x="3" y="2" width="14" height="16" rx="2" stroke="#1A3A5C" strokeWidth="1.3" />
          <line x1="6.5" y1="7" x2="13.5" y2="7" stroke="#1A3A5C" strokeWidth="1.1" />
          <line x1="6.5" y1="10" x2="13.5" y2="10" stroke="#1A3A5C" strokeWidth="1.1" />
          <line x1="6.5" y1="13" x2="10" y2="13" stroke="#1A3A5C" strokeWidth="1.1" />
        </svg>
      </div>
      <div className="vault-info">
        <div className="vault-title">{title}</div>
        <div className="vault-meta" dangerouslySetInnerHTML={{ __html: meta }} />
        <div className="vault-tags">
          {tags.map((tag, idx) => (
            <span key={idx} className="vault-tag">{tag}</span>
          ))}
        </div>
      </div>
      <div className="vault-actions">
        <button className="vault-fork">Fork ↗</button>
        <button className="vault-dl">↓ Save</button>
      </div>
    </div>
  );
}
