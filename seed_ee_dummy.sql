-- ============================================================
-- RAINFONT — Dummy EE Student Seed Data
-- Run in Supabase SQL Editor (uses service role / postgres superuser)
-- Creates 5 EE dummy students + posts in Bare Metal & Signal Chain
-- ============================================================

DO $$
DECLARE
  u1 uuid := 'a1000000-0000-0000-0000-000000000001'; -- Arjun Mehta
  u2 uuid := 'a1000000-0000-0000-0000-000000000002'; -- Dev Iyer (Guide)
  u3 uuid := 'a1000000-0000-0000-0000-000000000003'; -- Nisha Varma
  u4 uuid := 'a1000000-0000-0000-0000-000000000004'; -- Ravi Kumar
  u5 uuid := 'a1000000-0000-0000-0000-000000000005'; -- Meena Raghavan

  bm_id uuid;  -- Bare Metal node
  sc_id uuid;  -- Signal Chain node

  p1 uuid; p2 uuid; p3 uuid; p4 uuid; p5 uuid; p6 uuid; -- post IDs
BEGIN

  -- ── 1. Dummy auth users ──────────────────────────────────────
  INSERT INTO auth.users (
    instance_id, id, aud, role, email,
    encrypted_password, email_confirmed_at,
    raw_user_meta_data, created_at, updated_at, is_sso_user
  ) VALUES
    ('00000000-0000-0000-0000-000000000000', u1, 'authenticated', 'authenticated',
     'arjun@nitc.ac.in', '$2a$10$abcdefghijklmnopqrstuOPQRSTUVWXYZ0123456789ABCDE',
     now(), '{"full_name":"Arjun Mehta","institution":"NIT Calicut","year":"3rd yr","domain":"ee","folio_slug":"arjunmehta7234"}'::jsonb,
     now() - interval '30 days', now(), false),

    ('00000000-0000-0000-0000-000000000000', u2, 'authenticated', 'authenticated',
     'dev.iyer@iitm.ac.in', '$2a$10$abcdefghijklmnopqrstuOPQRSTUVWXYZ0123456789ABCDE',
     now(), '{"full_name":"Dev Iyer","institution":"IIT Madras","year":"4th yr","domain":"ee","folio_slug":"deviyer8821"}'::jsonb,
     now() - interval '60 days', now(), false),

    ('00000000-0000-0000-0000-000000000000', u3, 'authenticated', 'authenticated',
     'nisha.varma@bits-pilani.ac.in', '$2a$10$abcdefghijklmnopqrstuOPQRSTUVWXYZ0123456789ABCDE',
     now(), '{"full_name":"Nisha Varma","institution":"BITS Pilani","year":"2nd yr","domain":"ee","folio_slug":"nishavarma3310"}'::jsonb,
     now() - interval '20 days', now(), false),

    ('00000000-0000-0000-0000-000000000000', u4, 'authenticated', 'authenticated',
     'ravi.kumar@bits-pilani.ac.in', '$2a$10$abcdefghijklmnopqrstuOPQRSTUVWXYZ0123456789ABCDE',
     now(), '{"full_name":"Ravi Kumar","institution":"BITS Pilani","year":"3rd yr","domain":"ee","folio_slug":"ravikumar5592"}'::jsonb,
     now() - interval '45 days', now(), false),

    ('00000000-0000-0000-0000-000000000000', u5, 'authenticated', 'authenticated',
     'meena.r@nitt.edu', '$2a$10$abcdefghijklmnopqrstuOPQRSTUVWXYZ0123456789ABCDE',
     now(), '{"full_name":"Meena Raghavan","institution":"NIT Trichy","year":"PhD","domain":"ee","folio_slug":"meenar9941"}'::jsonb,
     now() - interval '90 days', now(), false)
  ON CONFLICT (id) DO NOTHING;

  -- ── 2. Update profiles (trigger already inserted rows) ───────
  UPDATE profiles SET domain = 'ee', year = '3rd yr', is_verified = true WHERE id = u1;
  UPDATE profiles SET domain = 'ee', year = '4th yr', is_verified = true, is_guide = true WHERE id = u2;
  UPDATE profiles SET domain = 'ee', year = '2nd yr', is_verified = true WHERE id = u3;
  UPDATE profiles SET domain = 'ee', year = '3rd yr', is_verified = true WHERE id = u4;
  UPDATE profiles SET domain = 'ee', year = 'PhD',    is_verified = true WHERE id = u5;

  -- ── 3. Get node IDs ──────────────────────────────────────────
  SELECT id INTO bm_id FROM nodes WHERE name = 'Bare Metal';
  SELECT id INTO sc_id FROM nodes WHERE name = 'Signal Chain';

  -- ── 4. Node memberships ──────────────────────────────────────
  INSERT INTO node_members (user_id, node_id) VALUES
    (u1, bm_id), (u1, sc_id),
    (u2, bm_id),
    (u3, sc_id),
    (u4, bm_id),
    (u5, sc_id), (u5, bm_id)
  ON CONFLICT DO NOTHING;

  -- ── 5. Posts ─────────────────────────────────────────────────
  INSERT INTO posts (id, author_id, node_id, title, abstract, body, intent, status, ai_domain_conf, guide_sealed, guide_sealed_by, guide_sealed_at, created_at) VALUES

  (gen_random_uuid(), u1, bm_id,
   'SPI DMA Transfer on STM32 — Race Condition Root Cause Found',
   'After three weeks of debugging intermittent data corruption on a high-speed SPI bus, the root cause was isolated to a cache coherency issue with the DMA controller on STM32F4 when the data buffer crosses a 1KB boundary.',
   'We were seeing random byte corruption on the SPI receive buffer about once every 200 packets — only under load. The issue was completely invisible in simulation. After instrumenting with a logic analyzer and cross-referencing with the STM32F4 reference manual section 9.3.12 (DMA limitations), we found that DMA transfers that cross a 1KB address boundary have undefined behavior when DCACHE is enabled without proper cache maintenance. Fix: align the DMA buffer to 32-byte boundaries using __attribute__((aligned(32))) and call SCB_CleanDCacheByAddr() before each transfer. Zero corruption since. Scope screenshots attached to Vault.',
   'milestone', 'live', 94, false, null, null,
   now() - interval '5 days') RETURNING id INTO p1;

  INSERT INTO posts (id, author_id, node_id, title, abstract, body, intent, status, ai_domain_conf, guide_sealed, guide_sealed_by, guide_sealed_at, created_at) VALUES
  (gen_random_uuid(), u2, bm_id,
   'UART Ring Buffer for FreeRTOS — Zero-Copy Implementation',
   'A zero-copy UART receive ring buffer that integrates with FreeRTOS task notification API. Tested on STM32H7 at 3Mbaud under interrupt load. Achieves 0 byte loss across 48-hour soak test.',
   'Standard UART DMA implementations either block or drop bytes under heavy CPU load. This implementation uses a hardware ring buffer in the DMA peripheral itself (circular mode), combined with FreeRTOS task notifications triggered by the IDLE line interrupt — meaning we get notified the moment a burst ends, not after a fixed timeout. The IDLE interrupt fires exactly when the UART line has been idle for one frame period, which is perfect for packet-based protocols. No malloc, no copy — the DMA writes directly to a statically allocated circular buffer and the task only receives a pointer + length. Benchmarks on STM32H7 at 3Mbaud: 0 byte loss over 48h. Code and integration guide in Vault.',
   'milestone', 'live', 97, true, u2, now() - interval '10 days',
   now() - interval '12 days') RETURNING id INTO p2;

  INSERT INTO posts (id, author_id, node_id, title, abstract, body, intent, status, ai_domain_conf, created_at) VALUES
  (gen_random_uuid(), u3, sc_id,
   'RF Balun Design for 2.4GHz — Measured vs Simulated Impedance',
   'Documented discrepancy between LTspice-simulated and VNA-measured impedance for a printed RF balun at 2.4GHz. Parasitic inductance from PCB traces accounts for 18% impedance shift at center frequency.',
   'Designed a printed PCB balun for a 2.4GHz BLE front-end using a λ/4 transmission line topology. LTspice simulation showed -31dB insertion loss at 2.44GHz. First prototype measured -28dB — 3dB worse than simulated. After careful S-parameter analysis with a calibrated VNA (SOLT calibration to PCB edge), isolated the source: trace parasitic inductance on the 50Ω feed lines adds ~0.8nH which shifts the center frequency down by ~80MHz. Second iteration with wider reference plane cutouts and shortened feed traces brought it to -30.4dB. Not perfect, but close enough for a printed solution. LTspice files and Gerbers in Vault.',
   'hypothesis', 'live', 91,
   now() - interval '3 days') RETURNING id INTO p3;

  INSERT INTO posts (id, author_id, node_id, title, abstract, body, intent, status, ai_domain_conf, created_at) VALUES
  (gen_random_uuid(), u4, bm_id,
   'MOSFET Gate Driver Ringing — Damping Without Compromising Switching Speed',
   'Gate driver oscillations at 40MHz were causing EMC failures on a 48V/20A synchronous buck converter. Root cause: parasitic inductance in gate loop. Solution: series gate resistor + ferrite bead combination, optimized for <5% overshoot.',
   'Our 48V synchronous buck was failing CISPR 25 Class 3 EMC tests. Probing the gate pin showed 40MHz ringing with ~8Vpp amplitude on a 12V gate signal — well into shoot-through territory. Measured gate loop inductance using a network analyzer: 14nH total (8nH from PCB trace, 6nH from gate wire bond). Options: reduce loop inductance (layout change needed), add gate resistance (slows switching), or use a gate ferrite bead (better frequency-selective damping). Tested Murata BLM18 1kΩ @ 100MHz in series with a 3.3Ω gate resistor: ringing reduced to <0.5Vpp, switching time increased by only 12ns. EMC test passed. Layout overlay and BOM in Vault.',
   'hypothesis', 'live', 89,
   now() - interval '7 days') RETURNING id INTO p4;

  INSERT INTO posts (id, author_id, node_id, title, abstract, body, intent, status, ai_domain_conf, created_at) VALUES
  (gen_random_uuid(), u5, sc_id,
   'PLL Lock Time Characterization on Low-Power 8-bit MCU',
   'Systematic characterization of PLL lock behavior on STM32L0 series across temperature (-20°C to 85°C) and supply voltage (1.8V to 3.6V). Lock time variance is 40% higher at cold temperatures — significant for wake-from-stop applications.',
   'Many low-power embedded designs rely on the MCU PLL locking quickly after waking from Stop mode. Datasheet specifies lock time as "typical" without worst-case or temperature coefficients. We characterized PLL lock time on 12 STM32L071 samples using a GPIO toggle synchronized to the PLL-ready interrupt, measured with a 1GHz scope. Results: at 25°C/3.3V, lock time is 148μs (±8μs). At -20°C/1.8V, lock time increases to 214μs (±18μs) — 45% longer and 2× more variable. This matters for applications targeting <500μs wake latency. Recommendation: add 100μs margin in worst-case analysis, or measure your specific lot. Raw data CSV and measurement setup photo in Vault.',
   'hypothesis', 'live', 93,
   now() - interval '2 days') RETURNING id INTO p5;

  INSERT INTO posts (id, author_id, node_id, title, abstract, body, intent, status, ai_domain_conf, created_at) VALUES
  (gen_random_uuid(), u1, bm_id,
   'PWM Frequency Aliasing on STM32 TIMx — Anyone Else Seeing This?',
   'Observing a 400Hz beat frequency on the output of a 20kHz PWM signal when the system timer (SysTick) is configured at 1kHz. Appears to be an interaction between the APB2 clock divider and TIM1 prescaler settings. Looking for anyone who has isolated this.',
   'Running TIM1 on STM32F103 at 20kHz PWM for a motor driver. With SysTick at 1kHz and APB2 prescaler at /2, the measured PWM frequency on a scope shows ~400Hz amplitude modulation on the duty cycle. Verified with FFT: 400Hz sideband at -32dBc. Tried disabling SysTick entirely — modulation disappears. Re-enabling at 500Hz changes the beat frequency to 200Hz. This strongly suggests interference from the clock tree. The APB2 prescaler forces a /2 divider on the timer input clock when APB2 != HCLK, which might be causing periodic jitter in the timer reload. Has anyone seen this? Anyone confirmed if this is silicon errata or a configuration issue?',
   'inquiry', 'live', 88,
   now() - interval '1 day') RETURNING id INTO p6;

  -- ── 6. Reviews ───────────────────────────────────────────────
  -- p1 (Arjun's SPI): reviewed by Dev, Ravi, Meena
  INSERT INTO reviews (post_id, reviewer_id, clarity, depth, body, created_at) VALUES
    (p1, u2, 5, 5, 'Excellent debug methodology. The cache coherency insight is non-obvious and the fix is clean. The 1KB boundary behavior is documented in the errata but easy to miss. Would suggest adding a compile-time assert to verify buffer alignment. This is exactly the kind of post Bare Metal needs.', now() - interval '4 days'),
    (p1, u4, 4, 5, 'Solid post. Took me 20 minutes to find this exact bug on an F7 last semester. The DMA circular mode with misaligned buffers is a classic trap. The scope traces would have been helpful but the written description is clear enough.', now() - interval '3 days'),
    (p1, u5, 5, 4, 'Well documented. The connection between the DMA limitation and the 1KB boundary needs a bit more explanation for readers unfamiliar with Cortex-M cache architecture, but the fix is correct and verified. Good work.', now() - interval '3 days');

  -- p2 (Dev's UART): reviewed by Arjun, Nisha
  INSERT INTO reviews (post_id, reviewer_id, clarity, depth, body, created_at) VALUES
    (p2, u1, 5, 5, 'This is the definitive reference for UART ring buffers on FreeRTOS. The use of the IDLE interrupt instead of a timer-based approach is elegant and the zero-copy claim is well-supported by the 48h test data. Already integrated a version of this in our project.', now() - interval '9 days'),
    (p2, u3, 4, 5, 'Very clear and practical. The explanation of why IDLE interrupt is superior to half-transfer + transfer-complete callbacks is the key insight here. The only thing missing is a note on how to handle buffer overflow gracefully.', now() - interval '8 days');

  -- p3 (Nisha's RF balun): reviewed by Meena, Ravi
  INSERT INTO reviews (post_id, reviewer_id, clarity, depth, body, created_at) VALUES
    (p3, u5, 4, 4, 'Good documentation of the simulation-to-measurement gap. The SOLT calibration note is important and often skipped. The 3dB difference is within what I would expect for a printed balun at 2.4GHz — real dielectric constant of FR4 varies from nominal by up to 10%. Worth mentioning for future readers.', now() - interval '2 days'),
    (p3, u4, 5, 3, 'Appreciated the systematic approach. The VNA measurements are the most valuable part. More context on the reference plane cutout geometry would make it easier to reproduce.', now() - interval '1 day');

  RAISE NOTICE 'Seed complete: 5 EE users, 6 posts, 7 reviews across Bare Metal and Signal Chain nodes.';

END $$;
