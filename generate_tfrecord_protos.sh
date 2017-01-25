#!/bin/bash
# Copyright 2016 Google Inc. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ==============================================================================

set -e

if [ "x$PROTO_OUT_DIR" == x ]; then
cat <<END
 Generate TFRecord protobufs. You can either set env vars such as
 IMAGENET_DATA_DIR, or enter them here.
END
  read -p "ImageNet data dir: " DATA_DIR
  read -p "Proto out dir:  " PROTO_OUT_DIR
fi

#SCRATCH_DIR="$(pwd)/raw-data"
#mkdir -p ${SCRATCH_DIR}

#TRAIN_DIR="${IMAGENET_DATA_DIR}/train"
#VALIDATION_DIR="${IMAGENET_DATA_DIR}/validation"

# Convert the XML files for bounding box annotations into a single CSV.
#echo "Extracting bounding box information from XML."
#BOUNDING_BOX_SCRIPT="./process_bounding_boxes.py"
#BOUNDING_BOX_FILE="${IMAGENET_DATA_DIR}/imagenet_2012_bounding_boxes.csv"
#BOUNDING_BOX_DIR="${IMAGENET_DATA_DIR}/bounding_boxes/"

#LABELS_FILE="imagenet_lsvrc_2015_synsets.txt"

#"${BOUNDING_BOX_SCRIPT}" "${BOUNDING_BOX_DIR}" "${LABELS_FILE}" \
# | sort >"${BOUNDING_BOX_FILE}"

BUILD_SCRIPT="./build_imagenet_data.py"
IMAGENET_META_FILE="imagenet_metadata.txt"
LABELS_FILE="imagenet_lsvrc_2015_synsets.txt"
TRAIN_DIR="${DATA_DIR}/data/train"
VALIDATION_DIR="${DATA_DIR}/data/validation"
BBOX_FILE="${DATA_DIR}/bounding_boxes/imagenet_2012_bounding_boxes.csv"

echo "Bounding boxes at ${BBOX_FILE}"

"${BUILD_SCRIPT}" \
  --train_directory="${TRAIN_DIR}" \
  --validation_directory="${VALIDATION_DIR}" \
  --output_directory="${PROTO_OUT_DIR}" \
  --imagenet_metadata_file="${IMAGENET_META_FILE}" \
  --labels_file="${LABELS_FILE}" \
  --bounding_box_file="${BBOX_FILE}"

