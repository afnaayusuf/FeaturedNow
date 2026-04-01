import React from 'react';
import './LedgerCard.css';

export default function LedgerCard({
  nodeName,
  nodeColor,
  isSealed,
  sealText,
  isParallel,
  parallelInstitutions,
  title,
  abstract,
  attachment,
  scores,
  authors,
  timestamp
}) {
  const [bookmarked, setBookmarked] = React.useState(false);

  return (
    <div className="ledger-card">
      <div className="card-top">
        <div className="card-node-row">
          <div className="node-chip">
            <div className="node-chip-dot" style={{ background: nodeColor }}></div>
            {nodeName}
          </div>
          <button className="card-bookmark" onClick={() => setBookmarked(!bookmarked)}>
            <svg width="16" height="16" viewBox="0 0 16 16" fill="none">
              <path 
                d="M4 2h8a1 1 0 011 1v11l-5-3-5 3V3a1 1 0 011-1z" 
                stroke={bookmarked ? "#C9922A" : "#8E9AAB"} 
                strokeWidth="1.3"
                fill={bookmarked ? "#C9922A" : "none"}
              />
            </svg>
          </button>
        </div>

        {isSealed && (
          <div className="seal-badge">
            ✦ Sealed · {sealText}
          </div>
        )}

        {isParallel && (
          <div className="parallel-tag">
            <svg width="10" height="10" viewBox="0 0 10 10" fill="none">
              <line x1="2" y1="2" x2="2" y2="8" stroke="#2B5F8E" strokeWidth="1.5" strokeLinecap="round" />
              <line x1="8" y1="2" x2="8" y2="8" stroke="#2B5F8E" strokeWidth="1.5" strokeLinecap="round" />
            </svg>
            Parallel · {parallelInstitutions} institutions
          </div>
        )}

        <div className="card-title" dangerouslySetInnerHTML={{ __html: title }} />
        <div className="card-abstract">{abstract}</div>

        {attachment && (
          <div className="attachment-pill">
            <svg width="12" height="12" viewBox="0 0 12 12" fill="none">
              <rect x="2" y="1" width="8" height="10" rx="1.5" stroke="#3A3A3C" strokeWidth="1.1" />
              <line x1="4" y1="4" x2="8" y2="4" stroke="#3A3A3C" strokeWidth="1" />
              <line x1="4" y1="6.5" x2="8" y2="6.5" stroke="#3A3A3C" strokeWidth="1" />
              <line x1="4" y1="9" x2="6.5" y2="9" stroke="#3A3A3C" strokeWidth="1" />
            </svg>
            {attachment}
          </div>
        )}

        <div className="score-row">
          {scores.map((score, idx) => (
            <div key={idx} className="score-pill">
              {score.label} {score.value && <span className="score-val">{score.value}</span>}
            </div>
          ))}
        </div>

        <div className="card-author-row">
          {authors.length === 1 ? (
            <>
              <div className="avatar-sm" style={{ background: authors[0].color }}>{authors[0].initials}</div>
              <div className="card-author-info">
                <div className="card-author-name">
                  {authors[0].name} {authors[0].verified && <span className="meridian-mark">✦</span>}
                </div>
                <div className="card-author-sub">{authors[0].sub}</div>
              </div>
            </>
          ) : (
            <>
              <div style={{ display: 'flex', gap: '-6px' }}>
                <div className="avatar-sm" style={{ background: authors[0].color, zIndex: 2, position: 'relative' }}>{authors[0].initials}</div>
                <div className="avatar-sm" style={{ background: authors[1].color, marginLeft: '-8px', zIndex: 1 }}>{authors[1].initials}</div>
              </div>
              <div className="card-author-info" style={{ marginLeft: '4px' }}>
                <div className="card-author-name" style={{ fontSize: '11.5px' }}>
                  {authors.map(a => a.name).join(' + ')} <span className="meridian-mark">✦</span>
                </div>
                <div className="card-author-sub">{authors[0].sub}</div>
              </div>
            </>
          )}
        </div>
      </div>
      
      <div className="card-divider"></div>
      
      <div className="card-actions">
        <button className="card-action-btn review">
          <svg width="13" height="13" viewBox="0 0 13 13" fill="none">
            <path d="M2 2h9a1 1 0 011 1v5a1 1 0 01-1 1H7l-2.5 2V9H2a1 1 0 01-1-1V3a1 1 0 011-1z" stroke="#4A7C6F" strokeWidth="1.2" fill="none" />
          </svg>
          Review
        </button>
        <div className="card-action-sep"></div>
        <button className="card-action-btn">
          <svg width="13" height="13" viewBox="0 0 13 13" fill="none">
            <path d="M9 2l2 2-6.5 6.5L2 9l.5-2.5L9 2z" stroke="#8E9AAB" strokeWidth="1.2" fill="none" />
          </svg>
          Parallel
        </button>
        <div className="card-action-right">{timestamp}</div>
      </div>
    </div>
  );
}
