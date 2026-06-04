import os
from docx import Document

BASE = "experiments"
REPORTS = "reports"

def latest():
    exps = sorted(os.listdir(BASE))
    return os.path.join(BASE, exps[-1])

exp = latest()

doc = Document()
doc.add_heading("LabReport v1.3", 0)

def add_file(title, path):
    if os.path.exists(path):
        doc.add_heading(title, level=1)
        with open(path) as f:
            doc.add_paragraph(f.read())

add_file("Metadata", f"{exp}/metadata.conf")
add_file("Commands", f"{exp}/commands.log")
add_file("Events", f"{exp}/events.log")
add_file("File Snapshots", f"{exp}/files.log")

# screenshots
img_dir = f"{exp}/screenshots"
if os.path.exists(img_dir):
    doc.add_heading("Screenshots", level=1)
    for img in sorted(os.listdir(img_dir)):
        doc.add_paragraph(img)

os.makedirs(REPORTS, exist_ok=True)

out = f"{REPORTS}/{os.path.basename(exp)}_v1.3.docx"
doc.save(out)

print("Report generated:", out)
