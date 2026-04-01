import React from 'react';
import TopNav from './components/TopNav';
import FilterTabs from './components/FilterTabs';
import FeaturedBanner from './components/FeaturedBanner';
import StatsStrip from './components/StatsStrip';
import SectionHead from './components/SectionHead';
import LedgerCard from './components/LedgerCard';
import ConveneCard from './components/ConveneCard';
import GuideCallout from './components/GuideCallout';
import VaultCard from './components/VaultCard';
import BottomNav from './components/BottomNav';

function App() {
  return (
    <>
      <TopNav />
      <div className="feed-scroll">
        <FilterTabs />
        <FeaturedBanner />
        <StatsStrip />
        
        <SectionHead title="Ledger — recent" actionText="Sort ↓" />
        
        <LedgerCard 
          nodeName="Bare Metal"
          nodeColor="#4A7C6F"
          isSealed={true}
          sealText="Dr. K. Menon, CSIR"
          isParallel={false}
          title="LoRa mesh over 3.2km at &lt;10mW — rural health monitoring network"
          abstract="A 9-node mesh covering 3.2km using SX1276 modules with custom MAC scheduling. Achieved 98.3% packet delivery in field trials. Full schematic + firmware attached."
          attachment="paper.pdf · 2.4MB"
          scores={[{ label: 'Clarity', value: '4.7' }, { label: 'Depth', value: '4.9' }, { label: '12 reviews' }]}
          authors={[{
            initials: 'AJ',
            name: 'Arjun Kumar',
            verified: true,
            sub: 'BITS Pilani · ECE · 4th yr',
            color: 'var(--navy-mid)'
          }]}
          timestamp="3d ago"
        />

        <ConveneCard 
          domain="Hardware"
          title="Rural Tech Challenge 2025 — India"
          daysLeft={6}
          teamSize="2–4 members"
          hostedBy="IIIT Hyderabad"
          registeredCount="248 students"
        />

        <GuideCallout 
          initials="RP"
          name="Dr. Reema Pillai"
          isVerified={true}
          role="Senior Researcher · ISRO Bangalore"
          node="Node / Bare Metal"
        />

        <SectionHead title="Vault — trending" actionText="Browse →" />

        <VaultCard 
          title="Digital Signal Processing — Complete Notes v3.1"
          meta="NIT Calicut · ECE Dept · Sem 5 · by Meera Nair ✦"
          tags={['DSP', 'FFT', 'Filters', '4.2MB PDF']}
        />

        <LedgerCard 
          nodeName="Gradient"
          nodeColor="#C9922A"
          isSealed={false}
          isParallel={true}
          parallelInstitutions={2}
          title="Federated learning for low-resource language models — a Kerala case study"
          abstract="Training on non-IID distributed data across 3 campuses without centralising Malayalam text corpora. Fed-Avg baseline vs our proposed adaptive aggregation."
          scores={[{ label: 'Clarity', value: '4.3' }, { label: 'Depth', value: '4.6' }, { label: '7 reviews' }]}
          authors={[
            {
              initials: 'PK',
              name: 'Priya Kumar',
              sub: 'CUSAT · NIT Calicut — Joint',
              color: '#B84A2B'
            },
            {
              initials: 'RA',
              name: 'Rohit Anand',
              color: '#1A3A5C'
            }
          ]}
          timestamp="1d ago"
        />

        <div style={{ height: '24px' }}></div>
      </div>
      <BottomNav />
    </>
  );
}

export default App;
