import React from 'react';
import './ConveneCard.css';

export default function ConveneCard({ domain, title, daysLeft, teamSize, hostedBy, registeredCount }) {
  return (
    <div className="convene-card">
      <div className="convene-header">
        <div>
          <div className="convene-type">Convene · {domain}</div>
          <div className="convene-title">{title}</div>
        </div>
        <div className="convene-deadline">{daysLeft}d left</div>
      </div>
      <div className="convene-body">
        <div className="convene-detail-row">
          <div className="convene-detail">
            <div className="convene-detail-label">Team size</div>
            <div className="convene-detail-val">{teamSize}</div>
          </div>
          <div className="convene-detail">
            <div className="convene-detail-label">Hosted by</div>
            <div className="convene-detail-val">{hostedBy}</div>
          </div>
          <div className="convene-detail">
            <div className="convene-detail-label">Registered</div>
            <div className="convene-detail-val">{registeredCount}</div>
          </div>
        </div>
        <button className="register-btn">Register — ID Verified ✦</button>
      </div>
    </div>
  );
}
