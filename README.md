# 📈 Job Placement Prediction Using AWS Big Data Pipeline

A complete cloud-native machine learning pipeline to predict student job placements. Built using distributed big data tools like HiveQL and PySpark, and deployed via AWS EMR, S3, and SageMaker.

---

## ☁️ Architecture Overview

<p align="center">
  <img src="images\Workflow_Diagram_finalpng.png" width="700"/>
</p>
<p align="center"><i>Figure: Cloud-based ML pipeline for job placement prediction</i></p>

---

## 🛠 Tech Stack

- **AWS S3**: Raw + cleaned data storage
- **AWS EMR**: Cluster with Hive + PySpark
- **HiveQL**: Data cleaning, transformation, feature generation
- **PySpark**: Model training (Random Forest, Logistic Regression)
- **SageMaker**: EDA + Visualizations in JupyterLab
- **Boto3**: Stored visual outputs in S3

---

## 🔁 End-to-End Pipeline

1. Upload raw dataset to `s3://group4project1/Input`
2. Clean and transform using Hive on EMR
3. Generate features (rank, encodings)
4. Train ML models with PySpark
5. Store predictions + visualizations in S3
6. EDA in SageMaker notebooks

---

## 📊 Visuals

### EDA Example

<p align="center">
  <img src="images\count_placementStatus.png" width="700"/>
</p>
<p align="center"><i>Figure: Count Placement Status</i></p>


### Feature Importance

<p align="center">
  <img src="images\Pair_Plot.png" width="500"/>
</p>

---

## ✅ Model Performance

| Model              | Accuracy |
|-------------------|----------|
| Decision Tree      | 74%      |
| Logistic Regression| 77%      |
| **Random Forest**  | **78% ✅** |

Random Forest was selected for its better performance and interpretability.

---

## 📁 Project Structure
job-placement-prediction/
├── notebooks/ # SageMaker & EMR notebooks
├── images/ # Architecture & analysis visuals
├── aws_workflow.md # Full AWS pipeline explanation
├── scripts/ # Hive queries
├── README.md # This file


---

## 🙋‍♂️ Author

**Binod Tandan**  
📫 [LinkedIn](https://linkedin.com/in/binodtandan) | [GitHub](https://github.com/BinodTandan)

---

## 📄 License

MIT License – Free to use, adapt, and learn from.

---


