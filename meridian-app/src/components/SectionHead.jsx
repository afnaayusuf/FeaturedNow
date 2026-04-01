import React from 'react';
import './SectionHead.css';

export default function SectionHead({ title, actionText, actionHref = "#" }) {
  return (
    <div className="section-head">
      <span className="section-head-title">{title}</span>
      <a className="section-head-action" href={actionHref}>{actionText}</a>
    </div>
  );
}
