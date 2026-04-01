import React from 'react';
import './FeaturedBanner.css';

export default function FeaturedBanner() {
  return (
    <div className="featured-banner">
      <div className="banner-grid-lines"></div>
      <div className="banner-node-tag">
        <span className="banner-node-dot"></span>
        Node / Gradient
      </div>
      <div className="banner-eyebrow">Sealed by Dr. Reema Pillai ✦</div>
      <div className="banner-title">Sparse attention for long-document reasoning in 1B parameter models</div>
      <div className="banner-meta-row">
        <div className="banner-author">
          <div className="avatar-sm banner-avatar">VS</div>
          <div className="author-info-sm">
            <span className="author-name-sm">Vaishnav Srinath</span>
            <span className="author-sub-sm">IIT Madras · CSE · 3rd yr</span>
          </div>
        </div>
        <div className="banner-stats">
          <span className="banner-stat">
            <svg width="11" height="11" viewBox="0 0 12 12" fill="none">
              <path d="M6 1l1.5 3 3.5.5-2.5 2.5.5 3.5L6 9 3 10.5l.5-3.5L1 4.5 4.5 4z" stroke="rgba(255,255,255,0.4)" strokeWidth="1.2" fill="none"/>
            </svg>
            4.8
          </span>
          <span className="banner-stat">
            <svg width="11" height="11" viewBox="0 0 12 12" fill="none">
              <path d="M2 2h8v6H6.5l-2 2V8H2V2z" stroke="rgba(255,255,255,0.4)" strokeWidth="1.2" fill="none"/>
            </svg>
            23
          </span>
        </div>
      </div>
    </div>
  );
}
