/*
 * SPDX-FileCopyrightText: Copyright (c) 2024 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
 * SPDX-License-Identifier: Apache-2.0
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#ifndef PYHOLOHUB_OPERATORS_VIDEO_DECODER_REQUEST_PYDOC_HPP
#define PYHOLOHUB_OPERATORS_VIDEO_DECODER_REQUEST_PYDOC_HPP

#include <string>

#include "macros.hpp"

namespace holoscan::doc {

namespace VideoDecoderRequestOp {

// PyVideoDecoderRequestOp Constructor
PYDOC(VideoDecoderRequestOp, R"doc(
Operator class to perform inference using an LSTM model.

Parameters
----------
fragment : Fragment
    The fragment that the operator belongs to.
input_frame: holoscan.core.IOSpec
    Decoder I/O related Parameters.
inbuf_storage_type: int
    Input buffer storage type.
async_scheduling_term: holoscan.AsynchronousCondition
    Async Scheduling Term required to get/set event state.
videodecoder_context: holoscan.ops.VideoDecoderContext
    Decoder context.
codec: int
    Video codec.
disableDPB: int
    Disable DPB.
output_format: str
    Output format.
name : str, optional
    The name of the operator.
)doc")

}  // namespace VideoDecoderRequestOp

}  // namespace holoscan::doc

#endif  // PYHOLOHUB_OPERATORS_VIDEO_DECODER_REQUEST_PYDOC_HPP
