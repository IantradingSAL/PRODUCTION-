-- ═══════════════════════════════════════════════════════════════
-- Supplier cost visibility — per-user permission
-- Adds:
--   employees.can_view_supplier_costs  → per-user switch (default: allowed)
--   suppliers.unit_cost / currency / cost_note → commercial cost of the
--     supplied unit (e.g. cost of an outsourced aligner)
-- Safe to run more than once.
-- ═══════════════════════════════════════════════════════════════

ALTER TABLE public.employees
  ADD COLUMN IF NOT EXISTS can_view_supplier_costs boolean NOT NULL DEFAULT true;

COMMENT ON COLUMN public.employees.can_view_supplier_costs IS
  'When false, supplier costs are hidden from this user everywhere in the app.';

DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM information_schema.tables
             WHERE table_schema = 'public' AND table_name = 'suppliers') THEN
    ALTER TABLE public.suppliers ADD COLUMN IF NOT EXISTS unit_cost numeric;
    ALTER TABLE public.suppliers ADD COLUMN IF NOT EXISTS currency text DEFAULT '€';
    ALTER TABLE public.suppliers ADD COLUMN IF NOT EXISTS cost_note text;
  END IF;
END $$;
