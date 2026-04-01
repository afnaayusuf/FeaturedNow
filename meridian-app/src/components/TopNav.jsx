import React from 'react';
import './TopNav.css';

export default function TopNav() {
  return (
    <div className="top-nav">
      <div className="wordmark">
        Meridian
        <div className="wordmark-dot"></div>
      </div>
      <div className="nav-right">
        <button className="icon-btn">
          <svg width="20" height="20" viewBox="0 0 20 20" fill="none">
            <circle cx="9" cy="9" r="6" stroke="#1A3A5C" strokeWidth="1.5"/>
            <path d="M14 14l3 3" stroke="#1A3A5C" strokeWidth="1.5" strokeLinecap="round"/>
          </svg>
        </button>
        <button className="icon-btn">
          <svg width="20" height="20" viewBox="0 0 20 20" fill="none">
            <path d="M10 2a5.5 5.5 0 00-5.5 5.5v3l-1.5 2.5h14l-1.5-2.5v-3A5.5 5.5 0 0010 2z" stroke="#1A3A5C" strokeWidth="1.4" strokeLinejoin="round"/>
            <path d="M8 15.5a2 2 0 004 0" stroke="#1A3A5C" strokeWidth="1.4"/>
          </svg>
          <div className="notif-dot"></div>
        </button>
        <div className="avatar-sm avatar-ak">AK</div>
      </div>
    </div>
  );
}
