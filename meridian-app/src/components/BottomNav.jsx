import React from 'react';
import './BottomNav.css';

export default function BottomNav() {
  return (
    <div className="bottom-nav">
      {/* Ledger (active) */}
      <div className="nav-item active">
        <div className="nav-icon">
          <svg width="22" height="22" viewBox="0 0 22 22" fill="none">
            <rect x="3" y="3" width="16" height="16" rx="2.5" stroke="#1A3A5C" strokeWidth="1.5"/>
            <line x1="7" y1="8" x2="15" y2="8" stroke="#1A3A5C" strokeWidth="1.5" strokeLinecap="round"/>
            <line x1="7" y1="11" x2="15" y2="11" stroke="#1A3A5C" strokeWidth="1.5" strokeLinecap="round"/>
            <line x1="7" y1="14" x2="11" y2="14" stroke="#1A3A5C" strokeWidth="1.5" strokeLinecap="round"/>
          </svg>
        </div>
        <div className="nav-label" style={{color: 'var(--navy)'}}>Ledger</div>
      </div>
      {/* Nodes */}
      <div className="nav-item">
        <div className="nav-icon">
          <svg width="22" height="22" viewBox="0 0 22 22" fill="none">
            <circle cx="11" cy="7" r="3" stroke="#8E9AAB" strokeWidth="1.4"/>
            <circle cx="4.5" cy="17" r="2.5" stroke="#8E9AAB" strokeWidth="1.4"/>
            <circle cx="17.5" cy="17" r="2.5" stroke="#8E9AAB" strokeWidth="1.4"/>
            <line x1="11" y1="10" x2="5.8" y2="14.5" stroke="#8E9AAB" strokeWidth="1.2"/>
            <line x1="11" y1="10" x2="16.2" y2="14.5" stroke="#8E9AAB" strokeWidth="1.2"/>
            <line x1="7" y1="17" x2="15" y2="17" stroke="#8E9AAB" strokeWidth="1.2" strokeDasharray="2 1.5"/>
          </svg>
        </div>
        <div className="nav-label">Nodes</div>
      </div>
      {/* Compose */}
      <div className="nav-item">
        <div className="nav-icon">
          <div className="nav-compose-btn">
            <svg width="18" height="18" viewBox="0 0 18 18" fill="none">
              <line x1="9" y1="3" x2="9" y2="15" stroke="#F5F0E8" strokeWidth="1.8" strokeLinecap="round"/>
              <line x1="3" y1="9" x2="15" y2="9" stroke="#F5F0E8" strokeWidth="1.8" strokeLinecap="round"/>
            </svg>
          </div>
        </div>
        <div className="nav-label">Publish</div>
      </div>
      {/* Vault */}
      <div className="nav-item">
        <div className="nav-icon">
          <svg width="22" height="22" viewBox="0 0 22 22" fill="none">
            <rect x="3" y="5" width="16" height="14" rx="2.5" stroke="#8E9AAB" strokeWidth="1.4"/>
            <circle cx="11" cy="12" r="2.5" stroke="#8E9AAB" strokeWidth="1.4"/>
            <circle cx="11" cy="12" r="0.8" fill="#8E9AAB"/>
            <line x1="13.5" y1="12" x2="16" y2="12" stroke="#8E9AAB" strokeWidth="1.2"/>
            <path d="M8 5V3.5A2.5 2.5 0 0113.5 3.5V5" stroke="#8E9AAB" strokeWidth="1.4"/>
          </svg>
          <div className="nav-pip"></div>
        </div>
        <div className="nav-label">Vault</div>
      </div>
      {/* Folio */}
      <div className="nav-item">
        <div className="nav-icon">
          <svg width="22" height="22" viewBox="0 0 22 22" fill="none">
            <circle cx="11" cy="8" r="3.5" stroke="#8E9AAB" strokeWidth="1.4"/>
            <path d="M4 19c0-3.9 3.1-7 7-7s7 3.1 7 7" stroke="#8E9AAB" strokeWidth="1.4" strokeLinecap="round"/>
          </svg>
        </div>
        <div className="nav-label">Folio</div>
      </div>
    </div>
  );
}
