# ☁️ AWS Workflow Summary – Job Placement Prediction Project

This document outlines the cloud architecture, data pipeline, and AWS tools used for a scalable job placement prediction system using big data technologies and machine learning.

---

## 📦 Cloud Architecture & Tools Used

| Component            | Tool/Service Used                            |
|----------------------|----------------------------------------------|
| Data Storage         | Amazon S3 (Raw & Cleaned Data Buckets)       |
| Distributed Querying | Apache Hive on AWS EMR                       |
| ML Model Training    | PySpark on JupyterLab via AWS EMR            |
| Data Visualization   | Amazon SageMaker (Jupyter Notebook)          |
| Cluster Management   | Amazon EMR (m5.xlarge instance)              |
| IAM Permissions      | Shared IAM user for team-wide access         |

---

## 🔁 End-to-End Pipeline

1. **Data Ingestion:**
   - Upload raw `.csv` dataset to AWS S3 (`s3://group4project1/Input/`)
   
2. **Data Preprocessing in Hive (via EMR):**
   - Remove nulls, duplicates using HiveQL
   - Encode categorical variables (e.g., Yes/No ➝ 1/0)
   - Add a CGPA + Test Score–based `RANK` using `RANK OVER()` window function
   - Create structured Hive tables, then export cleaned data to S3

3. **Model Training in PySpark (via EMR Notebooks):**
   - Train ML models: Random Forest, Decision Tree, Logistic Regression
   - Use structured CSV from S3 as input
   - Save model outputs back to S3

4. **Data Analysis & Visualization in SageMaker:**
   - Load results from S3
   - Perform EDA in Jupyter (histograms, box plots, heatmaps)
   - Store visual output in new S3 folder via `boto3`

---

## ✅ Features Engineered

- Binary encoding of Yes/No attributes
- New RANK column based on CGPA and Test Scores
- Multiple ML models evaluated
- Feature importance extracted and visualized

---

## 🧪 Results

| Model              | Accuracy | Chosen |
|-------------------|----------|--------|
| Decision Tree      | Lower    | ❌     |
| Logistic Regression| ~ High   | ❌     |
| Random Forest      | ✅ Best  | ✅     |

Random Forest selected due to slightly better performance and interpretability.

---

## 📊 Example Visualizations (via SageMaker)

- 📈 Histogram of CGPA vs Placement Status  
- 🧊 Heatmap of Feature Correlation  
- 📦 Boxplot: Placement vs CGPA  
- 🎯 Feature Importance Bar Graph  

---

## 🗂 Folder Structure in AWS

S3/
├── group4project1/
│ ├── Input/ # Raw CSV
│ ├── Processed/ # Cleaned CSV from Hive
│ └── Visualizations/ # EDA output (via SageMaker)

## 🔐 IAM Strategy

Created a dedicated **IAM user** for cross-service collaboration. All notebook/lab sessions and S3 access were shared securely via AWS CloudShell.

---

## 🎯 Summary

This project successfully demonstrated:
- End-to-end cloud-based ML pipeline
- Real-world scalability using Hive + PySpark + SageMaker
- Feature-rich, visually interpretable ML outputs