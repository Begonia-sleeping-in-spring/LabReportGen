import os
from docx import Document

BASE = "experiments"
REPORT_DIR = "reports"

def latest_exp():
    exps = sorted(os.listdir(BASE))
    return os.path.join(BASE, exps[-1])

exp = latest_exp()

doc = Document()
doc.add_heading("Lab Report", 0)

# metadata
meta = os.path.join(exp, "metadata.conf")
if os.path.exists(meta):
    doc.add_heading("Metadata", level=1)
    with open(meta) as f:
        doc.add_paragraph(f.read())

# commands
events = os.path.join(exp, "events.log")
if os.path.exists(events):
    doc.add_heading("Events Log", level=1)
    with open(events) as f:
        doc.add_paragraph(f.read())

# snapshots
snap = os.path.join(exp, "events.log")
doc.add_heading("Snapshots", level=1)
if os.path.exists(snap):
    with open(snap) as f:
        for line in f:
            if "SNAP" in line:
                doc.add_paragraph(line)

# screenshots
screens = os.path.join(exp, "screenshots")
if os.path.exists(screens):
    doc.add_heading("Screenshots", level=1)
    for img in sorted(os.listdir(screens)):
        doc.add_paragraph(img)

os.makedirs(REPORT_DIR, exist_ok=True)

out = os.path.join(REPORT_DIR, os.path.basename(exp) + "_report.docx")
doc.save(out)

print("Report generated:", out)
