import React from 'react';
import './StatsStrip.css';

export default function StatsStrip() {
  return (
    <div className="stats-strip">
      <div className="stat-card">
        <div className="stat-label">Your Nodes</div>
        <div className="stat-val">6</div>
        <div className="stat-sub">2 new posts</div>
      </div>
      <div className="stat-card">
        <div className="stat-label">Reviews due</div>
        <div className="stat-val">3</div>
        <div className="stat-sub">pending reply</div>
      </div>
      <div className="stat-card">
        <div className="stat-label">Inquiries</div>
        <div className="stat-val">1/1</div>
        <div className="stat-sub" style={{color: 'var(--rust)', fontSize: '9.5px'}}>limit reached</div>
      </div>
    </div>
  );
}
