import React from 'react';
import './GuideCallout.css';

export default function GuideCallout({ initials, name, isVerified, role, node }) {
  return (
    <div className="guide-callout">
      <div className="guide-avatar">{initials}</div>
      <div className="guide-info">
        <div className="guide-name">
          {name} {isVerified && <span className="guide-mark">✦</span>}
        </div>
        <div className="guide-role">{role}</div>
        <div className="guide-node">Active in {node}</div>
      </div>
      <button className="inquire-btn">Inquire</button>
    </div>
  );
}
