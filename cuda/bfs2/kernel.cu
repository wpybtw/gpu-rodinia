/*********************************************************************************
Implementing Breadth first search on CUDA using algorithm given in HiPC'07
  paper "Accelerating Large Graph Algorithms on the GPU using CUDA"

Copyright (c) 2008 International Institute of Information Technology - Hyderabad. 
All rights reserved.
  
Permission to use, copy, modify and distribute this software and its documentation for 
educational purpose is hereby granted without fee, provided that the above copyright 
notice and this permission notice appear in all copies of this software and that you do 
not sell the software.
  
THE SOFTWARE IS PROVIDED "AS IS" AND WITHOUT WARRANTY OF ANY KIND,EXPRESS, IMPLIED OR 
OTHERWISE.

The CUDA Kernel for Applying BFS on a loaded Graph. Created By Pawan Harish
**********************************************************************************/
#ifndef _KERNEL_H_
#define _KERNEL_H_

#define REG 10

__global__ void
Kernel(Node *g_graph_nodes, int *g_graph_edges, bool *g_graph_mask, bool *g_updating_graph_mask, bool *g_graph_visited, int *g_cost, int no_of_nodes)
{
	int tid = blockIdx.x * MAX_THREADS_PER_BLOCK + threadIdx.x;
	int r1, r2, r3, r4, r5, r6, r7, r8, r9, r10;
	if (tid < no_of_nodes && g_graph_mask[tid])
	{
		g_graph_mask[tid] = false;

		int k = g_graph_nodes[tid].starting;

		for (int i = 0; i < g_graph_nodes[tid].no_of_edges / REG; i++)
		{
			r1 = g_graph_edges[k++];
			r2 = g_graph_edges[k++];
			r3 = g_graph_edges[k++];
			r4 = g_graph_edges[k++];
			r5 = g_graph_edges[k++];
			r6 = g_graph_edges[k++];
			r7 = g_graph_edges[k++];
			r8 = g_graph_edges[k++];
			r9 = g_graph_edges[k++];
			r10 = g_graph_edges[k++];
			if (!g_graph_visited[r1])
			{
				g_cost[r1] = g_cost[tid] + 1;
				g_updating_graph_mask[r1] = true;
			}

			if (!g_graph_visited[r2])
			{
				g_cost[r2] = g_cost[tid] + 1;
				g_updating_graph_mask[r2] = true;
			}

			if (!g_graph_visited[r3])
			{
				g_cost[r3] = g_cost[tid] + 1;
				g_updating_graph_mask[r3] = true;
			}

			if (!g_graph_visited[r4])
			{
				g_cost[r4] = g_cost[tid] + 1;
				g_updating_graph_mask[r4] = true;
			}

			if (!g_graph_visited[r5])
			{
				g_cost[r5] = g_cost[tid] + 1;
				g_updating_graph_mask[r5] = true;
			}

			if (!g_graph_visited[r6])
			{
				g_cost[r6] = g_cost[tid] + 1;
				g_updating_graph_mask[r6] = true;
			}

			if (!g_graph_visited[r7])
			{
				g_cost[r7] = g_cost[tid] + 1;
				g_updating_graph_mask[r7] = true;
			}

			if (!g_graph_visited[r8])
			{
				g_cost[r8] = g_cost[tid] + 1;
				g_updating_graph_mask[r8] = true;
			}

			if (!g_graph_visited[r9])
			{
				g_cost[r9] = g_cost[tid] + 1;
				g_updating_graph_mask[r9] = true;
			}

			if (!g_graph_visited[r10])
			{
				g_cost[r10] = g_cost[tid] + 1;
				g_updating_graph_mask[r10] = true;
			}
		}

		for (size_t i = k; i < (g_graph_nodes[tid].no_of_edges + g_graph_nodes[tid].starting); i++)
		{
			int id = g_graph_edges[i];
			if (!g_graph_visited[id])
			{
				g_cost[id] = g_cost[tid] + 1;
				g_updating_graph_mask[id] = true;
			}
		}
	}
}

#endif
